class UserController < ApplicationController
  respond_to :html, :json
  before_filter :login_required, :only=>['welcome', 'change_password']


  def register
    @user = User.new(params[:user])
   # debugger
    @user.user_type = "user"
    
    if request.post?
      @user.image = File.open ('app/assets/images/fb_avatar.jpg')
      @user.password_validator = true
      @user.username_validator = true
      if @user.save
        
        session[:user_id] = User.authenticate(@user.username, @user.password).id
        flash[:message] = "Signup successful"
       # debugger
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
     
      if session[:user_id] = User.authenticate(params[:user][:username], params[:user][:password]).id
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
    session[:user_id] = nil
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

  def change_password
    @user = User.find_by_id params[:id]  
    if request.post?
       if User.authenticate(@user.username, params[:user][:current_password])
         
          @user.password = params[:user][:password]
          @user.password_confirmation = params[:user][:password_confirmation] 
          @user.password_validator = true
          @user.username_validator = true
          if @user.save
             #debugger
            
             flash[:message] = "You password is changed successfully"
             redirect_to edit_user_path(@user)
          else
           flash[:message] = "You didn't change password successfully, please do it again"
           redirect_to change_password_user_path(@user)
          end

       else 
           flash[:message] = "You didn't change password successfully, please do it again"
           redirect_to change_password_user_path(@user)
       end
    end  
     
  end

  def  edit       
       @user = User.find_by_id params[:id] 
      
  end
   
  def  update
    @user = User.find(params[:id])
    @user.password_validator = false
    @user.username_validator = true
    @user.update_attributes(params[:user])
    respond_with @user, :location => edit_user_path

  end

  
  def destroy
    User.find(params[:id]).destroy
    redirect_to moderators_path, :notice => "The post has been deleted"
  end


  def show

    @user = User.find(params[:id])
    @reviews = Review.find_all_by_user_id(params[:id])
    #debugger
  end

  def deleteUser
    User.find(params[:id]).destroy
  end

  def demoteModerator
    User.user_type = "not mod"
    User.save
  end

end
