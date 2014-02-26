class SessionsController < ApplicationController

  def create
    auth = request.env['omniauth.auth'] 
    user = User.find_by_provider_and_uid(auth['provider'], auth['uid']) || User.create_with_omniauth(auth)
    if user
      session[:user_id] = user.id
      redirect_to root_url, notice: "Signed in with #{auth['provider'].titleize}"
    else
      flash.now[:alert] = "Could not sign in user with #{auth['provider'].titleize}."
      redirect_to root_url
    end
  end

  def destroy
    sign_out
    redirect_to root_url, notice: "You signed out. See ya!"
  end
end
