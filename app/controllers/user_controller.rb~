class UserController < ApplicationController
  
  before_filter :login_required, :only=>['welcome', 'change_password']
  
  def register
    @user = User.new(params[:user])
    @user.user_type = "user"
    if request.post?
      if @user.save
        session[:user] = User.authenticate(@user.username, @user.password)
        flash[:message] = "Signup successful"
        redirect_to :controller => "phones" #TODO redirect to welcome page
      else
        flash[:warning] = "Signup unsuccessful"
      end
    end
  end

  def login
    if request.post?
      if session[:user] = User.authenticate(params[:user][:username], params[:user][:password])
        flash[:message] = "Login successful"
        redirect_to_stored
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

  def show
    @user = User.find(params[:id])
    @reviews = Review.find_all_by_phone_id(params[:id])
  end

end
