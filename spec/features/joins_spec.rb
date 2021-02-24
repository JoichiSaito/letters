require 'rails_helper'

RSpec.feature "Joins", type: :feature do
  scenario "参加ボタンを押す", js: true do
    user = FactoryBot.create(:user)
    sign_in_as user

    click_link "お知らせ作成"
    fill_in "タイトル(必須)", with: "Test Project"
    fill_in "本文(必須)", with: "Trying out Capybara"
    check "アンケート機能をつける"
    click_button "保存"

    expect(page).to have_content "参加する"

    click_link "参加する"

    expect(page).to have_content "キャンセルする"
  end
  
  scenario "参加者一覧ページ", js: true do
    user = FactoryBot.create(:user)
    sign_in_as user
  
    click_link "お知らせ作成"
    fill_in "タイトル(必須)", with: "Test Project"
    fill_in "本文(必須)", with: "Trying out Capybara"
    check "アンケート機能をつける"
    click_button "保存"
  
    expect(page).to have_content "お知らせを投稿しました"
    expect(page).to have_content "Test Project"

    click_link "参加する"
    click_link "参加者一覧"

    expect(page).to have_http_status :ok
    expect(page).to have_text("参加者一覧")
  end
end
