class UserController < ApplicationController
  
  before_filter :login_required, :only=>['welcome', 'change_password']
  
  def register
    @user = User.new(params[:user])
    @user.user_type = "user"
   
    if request.post?
      if @user.save
        session[:user] = User.authenticate(@user.username, @user.password)
        flash[:message] = "Signup successful"
      
        #send email for sign up
        @user.delay.signup_confirmation
        if current_user.user_type == "Moderator"
          redirect_to moderators_path
        else
        redirect_to :controller => "phones" #TODO redirect to welcome page
        end
      else
        flash[:warning] = "Signup unsuccessful"
      end
    end
  end

  def login
    if request.post?
     
      if session[:user] = User.authenticate(params[:user][:username], params[:user][:password])
        flash[:message] = "Login successful"
       
        if current_user.user_type == "Moderator"
          redirect_to moderators_path
        else
          redirect_to_stored
        end
      else
        flash[:warning] = "Login unsuccessful"
      end
    end
  end

  def logout
    session[:user] = nil
    flash[:message] = "Logged out"
    redirect_to :action => "login"
  end
  
  def forget_password
    if request.post?
       user = User.find_by_email params[:user][:email]
   
       if  user.nil? == false
           
           user.change_new_password
           flash[:message] = "You new password is being sended"
           redirect_to phones_path
       else
           flash[:message] = "Invalid email"
           redirect_to  user_forget_password_path
       end
       

      
    end
  
  end
  
  def destroy
    User.find(params[:id]).destroy
    redirect_to moderators_path, :notice => "The post has been deleted"
  end


  def show
    @user = User.find(params[:id])
    @reviews = Review.find_all_by_user_id(params[:id])
  end

  def deleteUser
    User.find(params[:id]).destroy
  end

  def demoteModerator
    User.user_type = "not mod"
    User.save
  end

end
