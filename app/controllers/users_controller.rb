class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user,   only: [:edit, :update]

  def show
    @user = User.find params[:id]
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user.assign_attributes(confirmed: false) if updated_email # must come first    
    @user.assign_attributes user_params_and_ip
    

    if @user.save
      flash[:notice] = "Your profile has been updated!"
      send_confirmation_email if !@user.confirmed
      sign_in_to_profile
    else
      flash[:notice] = "You submitted invalid information."
      render 'edit'
    end
  end

  def confirm
    @user = User.find params[:user_id]

    if @user.confirmation_code == params[:code]
      @user.update_attributes(confirmed: true, confirmation_code: nil)
      flash[:success] = "Confirmed your email address."
      sign_in_to_profile
    else
      flash[:error] = "Could not confirm your email. Try setting it again."
      redirect_to edit_user_path(@user)
    end
  end

  def user_params_and_ip
    params[:user].merge({ ip: request.remote_ip })
  end

  def send_confirmation_email
    TermsMailer.confirm_email(@user).deliver
    flash[:success] = "Check your email to finish confirming your account."
  end

  def updated_email
    @user.email != params[:user][:email]
  end

  def sign_in_to_profile
    sign_in @user
    redirect_to user_path(@user)
  end

  private

    def signed_in_user
      redirect_to root_url, notice: "Please sign in." unless signed_in?
    end

    def correct_user
      @user = User.find params[:id]
      redirect_to root_url, notice: "You cannot edit another user's profile." unless current_user?(@user)
    end
end
