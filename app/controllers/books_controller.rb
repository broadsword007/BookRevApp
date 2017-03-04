class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :destroy, :update]
  def index
    @books=Book.all.order("created_at DESC");
  end
  def new
    @book=Book.new ;
  end
  def create
    @book=Book.new(book_params)
    if @book.save
      redirect_to root_path
    else
      redirect_to new_book_path, notice: "New Book creation failed."
    end
  end

  def show

  end

  def destroy
    @book.destroy
    redirect_to books_path
  end
  def edit

  end
  def update
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      redirect_to :back, notice: "Book update failed"
    end
  end
  private
  def book_params
    params.require(:book).permit(:title, :description, :author) ;
  end
  def find_book
    @book=Book.find(params[:id])
  end
end
