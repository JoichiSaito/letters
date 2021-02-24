class RelationshipsController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: %i[destroy]
  
  def create
    follow = current_user.active_relationships.create(follower_id: params[:user_id])
  end
  
  def destroy
    follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
    follow.destroy
  end
  
  private
  
  def ensure_correct_user
    if current_user.email === 'rails@taro.com'
      flash[:notice] = '権限がありません'
      redirect_to root_path
    end
  end
  
  def set_user
    @user = User.find(params[:user_id])
  end
end
