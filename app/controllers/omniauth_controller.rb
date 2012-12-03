class OmniauthController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id

    redirect_to phones_path
  end


end


