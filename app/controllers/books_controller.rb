class BooksController < ApplicationController
  before_action :authenticate_user!, only:[:new, :edit, :destroy]
  before_action :set_book, only:[:show, :edit, :update, :destroy]
  before_action :move_to_index, except: [:index, :show, :search]
  
  def index
    @books = Book.includes(:user)
    @books = Book.page(params[:page]).per(4).order("created_at DESC")
    @random = Book.order("RAND()").limit(2)
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @book.comments.includes(:user)
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to root_path
  end

  def search
    @books = Book.search(params[:keyword])
  end


  private
  def book_params
    params.require(:book).permit(:title, :image, :review).merge(user_id: current_user.id)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

end
