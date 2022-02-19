class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :move_to_signed_in
  def new
    @book = Book.new
  end

  def index
    @books = Book.all
    @book= Book.new(params[:id])
  end

  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: 'You have created book successfully.'
    else
      render :index
    end
  end

  def show
    @books = Book.all
    @new_book = Book.new
    @book= Book.find(params[:id])
    @users = User.all
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book.id), notice: 'You have updated book successfully.'
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to '/books'
  end

 private

  def authenticate_user!
     @book = Book.find(params[:id])
     unless @book.user == current_user
     redirect_to '/books'
     end
  end


def move_to_signed_in
    unless user_signed_in?
      redirect_to  '/users/sign_in'
    end
end
  def book_params
    params.require(:book).permit(:title, :body, :profile_image)
  end



end
