class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    request = current_user.passive_requests.find_by(refollowing_id: params[:user_id])
    request.destroy
    follow = current_user.passive_relationships.create(following_id: params[:user_id])
    redirect_to user_requests_path(current_user)
  end

  def destroy
    request = current_user.passive_requests.find_by(refollowing_id: params[:user_id])
    request.destroy
    redirect_to user_requests_path(current_user)
  end
end
