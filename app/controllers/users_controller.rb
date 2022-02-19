class UsersController < ApplicationController
  before_action :move_to_signed_in
  before_action :authenticate_user!, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @new_book = Book.new
  end

  def index
    @users = User.all
    @new_book = Book.new
  end

  def edit
    @user = User.find(params[:id])

  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(current_user.id), notice: 'You have updated user successfully.'
    else
    render :edit
    end
  end

  private

  def authenticate_user!
    user = User.find(params[:id])
    if current_user != user
      redirect_to user_path(current_user.id)
    end
  end


def move_to_signed_in
    unless user_signed_in?
      redirect_to  '/users/sign_in'
    end
end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end


end
