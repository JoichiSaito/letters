require 'rails_helper'

RSpec.feature 'Homes', type: :feature do
  feature 'ゲストユーザーとして' do
    scenario 'トップページ' do
      visit root_path

      expect(page).to have_text('今すぐお知らせを届けよう！')
      expect(page).to have_text('新規登録')
      expect(page).to have_text('ログイン')
    end
  end

  feature 'ログインユーザーとして' do
    scenario 'トップページ' do
      user = FactoryBot.create(:user_school)
      sign_in_as user

      visit root_path

      expect(page).to have_text('レイルズ小学校')
    end
  end
end
