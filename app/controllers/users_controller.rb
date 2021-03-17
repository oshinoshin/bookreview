class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @name = @user.name
    @books = @user.books
    # @user = Kaminari.paginate_array(@books.user_id).page(params[:page]).per(4)
  end
end
