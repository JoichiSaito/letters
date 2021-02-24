require 'rails_helper'

RSpec.feature "Homes", type: :feature do
  feature "ゲストユーザーとして" do
    scenario "トップページ" do
      visit root_path

      expect(page).to have_text("大切なお知らせ、もう見逃さない")
    end
  end

  feature "ログインユーザーとして" do
    scenario "トップページ" do
      user = FactoryBot.create(:user_school)
      sign_in_as user

      visit root_path

      expect(page).to have_text("レイルズ小学校")
    end
  end
end
