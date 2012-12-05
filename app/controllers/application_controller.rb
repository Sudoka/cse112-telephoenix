class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :moder?, :admin?

  protected
  def moder?
    user = User.find_by_id(session[:user_id])
    if user.user_type == "Moderator"  
      true
    else
      false
    end
  end

  protected
  def admin?
    user = User.find_by_id(session[:user_id])
    if user.user_type == "Admin"
      true
    else
      false
    end
  end

  before_filter :login_required, :only=>['moderator_required', 'admin_required']

  #Verifies that the user is currently logged in.
  def login_required
    if session[:user_id]
      return true
    end
    flash[:warning] = "Please login to continue!"
    session[:return_to] = request.fullpath
    redirect_to :controller => "User", :action => "login"
    return false
  end

  #Verifies that the current user is at least a moderator.
  def moderator_required
    user = User.find_by_id(session[:user_id])
    if moder? || admin?
      return true
    end
    flash[:warning] = "You have attempted to access a page you are not supposed to. You have been logged out for security."
    session[:user_id] = nil
    redirect_to :controller => "User", :action => "login"
    return false
  end

  #Verifies that the current user is an admin.
  def admin_required
    user = User.find_by_id(session[:user_id])
    if user.user_type == "Admin"
      return true
    end
    flash[:warning] = "You have attempted to access a page you are not supposed to. You have been logged out for security."
    session[:user_id] = nil
    redirect_to :controller => "User", :action => "login"
    return false
  end

  #Returns the current users User object.
  def current_user
    User.find_by_id(session[:user_id])
  end

  #Redirects to the stored link that was last attempted.
  def redirect_to_stored
      #debugger
    if return_to = session[:return_to]
      session[:return_to] = nil
      redirect_to return_to
    else
      redirect_to :controller => "phones"#:controller=>"User", :action=>'welcome'
    end
  end

  def can_edit(user)
    current = User.find_by_id(session[:user_id])
    if current == user || moder? || admin?
      return true
    else
      return false
    end
  end
  
end
