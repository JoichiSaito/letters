require 'rails_helper'

RSpec.feature "Relationships", type: :feature do
  scenario "フォローボタンを押す", js: true do
    visit new_user_registration_path
    fill_in "user[name]", with: "スプリング小学校"
    fill_in "メールアドレス(※登録後は変更できません)", with: "springs@example.com"
    fill_in "user[password]", with: "springshogakko"
    fill_in "user[password_confirmation]", with: "springshogakko"
    select "学校", from: "user_position"
    click_button "登録する"
    click_link "ログアウト"

    visit root_path
    user = FactoryBot.create(:user_parent)
    sign_in_as user

    visit users_path
    click_link "スプリング小学校"

    expect(page).to have_content "フォローする"
    click_link "フォローする"

    expect(page).to have_content "フォロー解除"
    click_link "フォロー解除"

    expect(page).to have_content "フォローする"
  end
end
