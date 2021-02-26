require 'rails_helper'

RSpec.describe User, type: :model do
  it '有効な1つ目のファクトリを持つこと' do
    expect(FactoryBot.build(:user_school)).to be_valid
  end

  it '有効な2つ目のファクトリを持つこと' do
    expect(FactoryBot.build(:user_school2)).to be_valid
  end

  it '有効な3つ目のファクトリを持つこと' do
    expect(FactoryBot.build(:user_parent)).to be_valid
  end

  it '名前が無ければ無効であること' do
    user = User.new(name: nil)
    expect(user).to be_invalid
  end

  it 'メールアドレスが無ければ無効であること' do
    user = User.new(email: nil)
    expect(user).to be_invalid
  end

  it 'パスワードが無ければ無効であること' do
    user = User.new(password: nil)
    expect(user).to be_invalid
  end

  it '名前が30文字以上であれば無効であること' do
    user = User.new(name: 'a' * 31)
    expect(user).to be_invalid
  end

  it '重複したメールアドレスなら無効であること' do
    FactoryBot.create(:user_school)
    user2 = User.new(email: 'rails@example.com')
    expect(user2).to be_invalid
  end

  it 'パスワードが5文字以下であれば無効であること' do
    user = User.new(password: 'a' * 5)
    expect(user).to be_invalid
  end

  it 'ポジションが無ければ無効であること' do
    user = User.new(position: nil)
    expect(user).to be_invalid
  end
end
