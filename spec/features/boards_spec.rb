require 'rails_helper'

RSpec.feature 'Boards', type: :feature do
  let(:user_school) {FactoryBot.create(:user_school)}

  before do
    sign_in_as user_school
  end

  scenario 'ユーザーは新しいお知らせを作成する' do
    expect do
      click_link 'お知らせ作成'
      fill_in 'タイトル(必須・最大30文字)', with: 'Test Project'
      fill_in '本文(必須・最大500文字)', with: 'Trying out Capybara'
      check 'アンケート機能をつける'
      click_button '保存'

      expect(page).to have_content 'お知らせを投稿しました'
      expect(page).to have_content 'Test Project'
      expect(page).to have_content '参加する'
    end.to change(user_school.boards, :count).by(1)
  end

  scenario 'ユーザーはお知らせを編集する' do
    click_link 'お知らせ作成'
    fill_in 'タイトル(必須・最大30文字)', with: 'Test Project'
    fill_in '本文(必須・最大500文字)', with: 'Trying out Capybara'
    click_button '保存'

    expect(page).to have_content 'お知らせを投稿しました'
    expect(page).to have_content 'Test Project'

    click_link '編集'
    fill_in 'タイトル(必須・最大30文字)', with: 'Test Project again'
    fill_in '本文(必須・最大500文字)', with: 'Trying out Capybara'
    click_button '保存'

    expect(page).to have_content 'お知らせを更新しました'
    expect(page).to have_content 'Test Project again'
  end

  scenario 'ユーザーはお知らせを削除する' do
    click_link 'お知らせ作成'
    fill_in 'タイトル(必須・最大30文字)', with: 'Test Project'
    fill_in '本文(必須・最大500文字)', with: 'Trying out Capybara'
    click_button '保存'

    click_link '削除'

    expect(page).to have_content 'お知らせを削除しました'
    expect(current_path).to eq user_path(user_school)
  end
end
