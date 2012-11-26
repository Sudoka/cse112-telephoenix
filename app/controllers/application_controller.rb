class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :login_required, :only=>['moderator_required', 'admin_required']

  #Verifies that the user is currently logged in.
  def login_required
    if session[:user]
      return true
    end
    flash[:warning] = "Please login to continue!"
    session[:return_to] = request.fullpath
    redirect_to :controller => "user", :action => "login"
    return false
  end

  #Verifies that the current user is at least a moderator.
  def moderator_required
    if session[:user].user_type == "mod" || session[:user].user_type == "admin"
      return true
    end
    flash[:warning] = "You have attempted to access a page you are not supposed to. You have been logged out for security."
    session[:user] = nil
    redirect_to :controller => "user", :action => "login"
    return false
  end

  #Verifies that the current user is an admin.
  def admin_required
    if session[:user].user_type == "admin"
      return true
    end
    flash[:warning] = "You have attempted to access a page you are not supposed to. You have been logged out for security."
    session[:user] = nil
    redirect_to :controller => "user", :action => "login"
    return false
  end

  #Returns the current users User object.
  def current_user
    session[:user]
  end

  #Redirects to the stored link that was last attempted.
  def redirect_to_stored
    if return_to = session[:return_to]
      session[:return_to] = nil
      redirect_to return_to
    else
      redirect_to :controller => "phones"#:controller=>"user", :action=>'welcome'
    end
  end
  
end
