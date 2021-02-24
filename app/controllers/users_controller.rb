class UsersController < ApplicationController
  before_action :set_user, only: %i[show follows followers]
  before_action :authenticate_user!

  def index
    @q = User.where(position: 0).order('id DESC').ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page])
  end
  
  def show
    @board = Board.where(user_id: @user.id).order('id DESC')
    @boards = @board.page(params[:page])
  end

  def follows
    @users = @user.followings.page(params[:page])
  end

  def followers
    @users = @user.followers.page(params[:page])
  end
  
  private

  def ensure_correct_user
    @user = User.find_by(id: params[:id])
    if @user.id != @current_user.id || @current_user.email === 'rails@taro.com'
      flash[:notice] = '権限がありません'
      redirect_to root_path
    end
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
