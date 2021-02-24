require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  feature "Visit" do
    scenario "ログイン" do
      visit new_user_session_path

      expect(page).to have_text("メールアドレス")
      expect(page).to have_text("パスワード")
    end
  end

  feature "New controll" do
    scenario "ログイン成功" do
      user = FactoryBot.create(:user_school)
      sign_in_as user
      
      expect(page).to have_http_status :ok
      expect(current_path).to eq user_path(user)
      expect(page).to have_text("ログインしました")
      expect(page).to have_text("レイルズ小学校")
    end
  end
end
