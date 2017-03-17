class BooksController < ApplicationController
  before_action :find_book, only: [:edit, :destroy, :update]
  before_action :check_user_signed_in, only: [:new, :create, :update, :destroy]
  def index
    if(params[:category]=="all" or params[:category]=="" or params[:category]==nil)
      @books=Book.all
      @current_category="All"
    else
      category=Category.find_by_name(params[:category])
      if(category!=nil)
        @books=category.books
        @current_category=category.name
      end
      if(@books==nil)
        redirect_back(fallback_location: books_path(category: "all"))
      end
    end
  end
  def new
    if(!user_signed_in?)
      redirect_to new_user_session_path
    end
    @book=Book.new ;
  end
  def create
    puts "\n\n Params are \n"
    puts params
    puts "\n\n\n"
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    if @book.save
      redirect_to root_path
    else
      redirect_to new_book_path, notice: "New Book creation failed."
    end
  end

  def show
    @book=Book.find(params[:id])
    @average_reviews=@book.reviews.average(:rating)
    @review_count=@book.reviews.count
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

    params.require(:book).permit(:title, :description, :author, :category_id, :book_img) ;
  end
  def find_book
    if(!user_signed_in?)
      redirect_to new_user_session_path
    end
    @book=Book.find(params[:id])
    @average_reviews=@book.reviews.average(:rating)
    puts "\n\n\n #{@average_reviews} \n\n\n"
  end
  def check_user_signed_in
    if(!user_signed_in?)
      redirect_to new_user_session_path
    end
  end
end
