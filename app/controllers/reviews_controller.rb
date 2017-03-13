class ReviewsController < ApplicationController
  before_action :find_book, only: [:create, :new, :edit, :update, :destroy]
  before_action :find_review, only: [:edit, :update, :destroy]
  before_action :check_user_signed_in, only: [:new, :create, :edit, :update, :destroy]
  def new
    @reviews=Review.new
  end
  def create
    @review=Review.new(review_params)
    @review.book_id=@book.id
    @review.user_id=current_user.id
    if @review.save
      redirect_to book_path(@book)
    else
      redirect_to books_path
    end
  end
  def edit

  end
  def update
    if @review.update(review_params)
      redirect_to book_path(@book)
    else
      render :edit
    end
  end
  def destroy
    @review.destroy
    redirect_to book_path(@book)
  end
  private
  def review_params
    params.require(:review).permit(:rating, :comment)
  end
  def find_book
    @book=Book.find_by(id: params[:book_id])
  end
  def find_review
    @review=Review.find(params[:id])
  end
  def check_user_signed_in
    if(!user_signed_in?)
      redirect_to new_user_session
    end
  end
end
