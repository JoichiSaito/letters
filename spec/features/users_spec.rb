require 'rails_helper'

RSpec.feature "Users", type: :feature do
  feature "Visit" do
    scenario "新規登録" do
      visit new_user_registration_path

      expect(page).to have_text("メールアドレス")
      expect(page).to have_text("パスワード")
    end
  end
  
  feature "New controll" do
    scenario "ユーザーの新規登録" do
      expect {
        visit new_user_registration_path
        fill_in "user[name]", with: "レイルズ小学校"
        fill_in "メールアドレス(※登録後は変更できません)", with: "rails@example.com"
        fill_in "user[password]", with: "railsshogakko"
        fill_in "user[password_confirmation]", with: "railsshogakko"
        select "学校", from: "user_position"
        click_button "登録する"

        expect(page).to have_http_status :ok
        expect(page).to have_text("レイルズ小学校")
      }.to change(User, :count).by(1)
    end
  end

  feature "Visit as loginuser" do
    scenario "フォローページ" do
      user = FactoryBot.create(:user_school)
      sign_in_as user

      visit user_path(user)
      click_link "フォロー"
      expect(page).to have_http_status :ok
      expect(current_path).to eq follows_user_path(user)
      expect(page).to have_text("フォロー")
    end

    scenario "フォロワーページ" do
      user = FactoryBot.create(:user_school)
      sign_in_as user

      visit user_path(user)
      click_link "フォロワー"
      expect(page).to have_http_status :ok
      expect(current_path).to eq followers_user_path(user)
      expect(page).to have_text("フォロワー")
    end

    scenario "フォローリクエスト一覧ページ" do
      user = FactoryBot.create(:user_school)
      sign_in_as user

      visit user_path(user)
      click_link "フォローリクエスト一覧"
      expect(page).to have_http_status :ok
      expect(page).to have_text("フォローリクエスト一覧")
    end
  end
end
