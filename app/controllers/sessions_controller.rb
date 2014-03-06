class SessionsController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    ip   = request.remote_ip
    user = User.find_by_provider_and_uid(auth['provider'], auth['uid']) || User.create_with_omniauth_and_ip(auth, ip)
    if user
      session[:user_id] = user.id

      if user.confirmed?
        flash[:success] = "Signed in with #{auth['provider'].titleize}"
        redirect_to root_url
      else
        flash[:success] = "Please add an email address to your profile."
        redirect_to edit_user_path(user)
      end

    else
      flash.now[:notice] = "Could not sign in user with #{auth['provider'].titleize}."
      redirect_to root_url
    end
  end

  def destroy
    sign_out
    flash[:success] = "You signed out. See ya!"
    redirect_to root_url
  end
end
