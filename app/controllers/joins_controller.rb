class JoinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_join

  def show
    @joins = @board.joins.includes(:user).page(params[:page])
  end

  def create
    @join = current_user.joins.create(board_id: params[:board_id])
  end

  def destroy
    @join = Join.find_by(user_id: current_user.id, board_id: params[:board_id])
    @join.destroy
  end

  private

  def set_join
    @board = Board.find(params[:board_id])
  end
end
