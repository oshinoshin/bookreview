class BooksController < ApplicationController
  
  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book =Book.new(book_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end
  
end
