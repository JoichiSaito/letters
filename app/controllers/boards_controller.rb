class BoardsController < ApplicationController
  before_action :set_board, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: %i[edit update destroy]
  before_action :board_reject_user, only: %i[new create]

  def new
    @board = Board.new(flash[:board])
  end

  def create
    board = Board.new(board_params)
    board.user_id = current_user.id
    if board.save
      flash[:notice] = 'お知らせを投稿しました'
      redirect_to board
    else
      redirect_to new_board_path, flash: {
        board: board,
        error_messages: board.errors.full_messages
      }
    end
  end

  def show; end

  def edit; end

  def update
    if @board.update(board_params)
      flash[:notice] = 'お知らせを更新しました'
      redirect_to @board
    else
      redirect_to board_path, flash: {
        board: @board,
        error_messages: @board.errors.full_messages
      }
    end
  end

  def destroy
    @board.destroy
    flash[:notice] = 'お知らせを削除しました'
    redirect_to current_user
  end

  private

  def ensure_correct_user
    @board = Board.find_by(id: params[:id])
    if @board.user_id != current_user.id
      flash[:notice] = '権限がありません'
      redirect_to root_path
    end
  end

  def board_reject_user
    if current_user.position === 1
      flash[:notice] = '保護者はお知らせを作成できません'
      redirect_to root_path
    end
  end

  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:user_id, :title, :content, :questionnaire)
  end
end
