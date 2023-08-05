class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
    @user = current_user
    @user_introduction = @user.introduction
    @user_profile_image = @user.profile_image
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params_update)
       flash[:notice] = "You have updated user successfully."
       redirect_to user_path
    else
      render :edit
    end
  end

  private

  def user_params_update
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

end
