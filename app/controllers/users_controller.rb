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
    if @user.update_attributes(params[:user])
      flash[:alert] = "Your profile has been updated!"
      sign_in @user
      redirect_to user_path(@user)
    else
      flash[:alert] = "You submitted invalid information."
      render 'edit'
    end
  end

  private

    def signed_in_user
      redirect_to root_url, notice: "Please sign in." unless signed_in?
    end

    def correct_user
      @user = User.find params[:id]
      # puts "@user: #{@user.name} (#{@user.id}) | current_user: #{current_user.name} (#{current_user.id})"
      redirect_to root_url, notice: "You cannot edit another user's profile." unless current_user?(@user)
    end
end
