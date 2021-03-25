class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @name = @user.name
    @books = @user.books.page(params[:page]).per(4).order("created_at DESC")
  end
end
