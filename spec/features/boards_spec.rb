require 'rails_helper'

RSpec.feature "Boards", type: :feature do
  scenario "ユーザーは新しいお知らせを作成する" do
    user = FactoryBot.create(:user_school)
    sign_in_as user

    expect {
      click_link "お知らせ作成"
      fill_in "タイトル(必須・最大30文字)", with: "Test Project"
      fill_in "本文(必須・最大500文字)", with: "Trying out Capybara"
      check "アンケート機能をつける"
      click_button "保存"

      expect(page).to have_content "お知らせを投稿しました"
      expect(page).to have_content "Test Project"
      expect(page).to have_content "参加する"
    }.to change(user.boards, :count).by(1)
  end

  scenario "ユーザーはお知らせを編集する" do
    user = FactoryBot.create(:user_school)
    sign_in_as user

    click_link "お知らせ作成"
    fill_in "タイトル(必須・最大30文字)", with: "Test Project"
    fill_in "本文(必須・最大500文字)", with: "Trying out Capybara"
    click_button "保存"

    expect(page).to have_content "お知らせを投稿しました"
    expect(page).to have_content "Test Project"

    click_link "編集"
    fill_in "タイトル(必須・最大30文字)", with: "Test Project again"
    fill_in "本文(必須・最大500文字)", with: "Trying out Capybara"
    click_button "保存"

    expect(page).to have_content "お知らせを更新しました"
    expect(page).to have_content "Test Project again"
  end
end
