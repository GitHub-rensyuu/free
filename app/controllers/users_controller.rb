class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    # @books = @user.books
    @book = Book.new
    @books = Book.where(user_id: @user.id)
    @today_book =  @books.created_today
    # @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def index
    @users = User.all
    @book = Book.new
  # 2.endがない
  end

  def edit
    @user = User.find(params[:id])
    # 他ユーザーのページの場合自分のページに移動
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def withdrawal
    @user = User.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  def follows
    user = User.find(params[:id])
    @users = user.following_user
    # @users = user.following_user.page(params[:page]).per(3).reverse_order
  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_user
    # @users = user.follower_user.page(params[:page]).per(3).reverse_order
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end