require 'rails_helper'

RSpec.describe Board, type: :model do

  it '題名が無ければ無効であること' do
    board = Board.new(title: nil)
    expect(board).to be_invalid
  end

  it '本文が無ければ無効であること' do
    board = Board.new(content: nil)
    expect(board).to be_invalid
  end

  it 'ユーザーIDが無ければ無効であること' do
    board = Board.new(user_id: nil)
    expect(board).to be_invalid
  end

  it '題名が31文字以上であれば無効であること' do
    board = Board.new(title: 'a' * 31)
    expect(board).to be_invalid
  end

  it '本文が501文字以上であれば無効であること' do
    board = Board.new(content: 'a' * 501)
    expect(board).to be_invalid
  end
end
