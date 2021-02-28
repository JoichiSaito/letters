require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  let(:user_school) {FactoryBot.create(:user_school)}

  feature 'Visit' do
    scenario '新規登録' do
      visit new_user_registration_path

      expect(page).to have_text('メールアドレス')
      expect(page).to have_text('パスワード')
    end
  end

  feature 'New controll' do
    scenario 'ユーザーの新規登録' do
      expect do
        visit new_user_registration_path
        fill_in 'user[name]', with: 'スプリング小学校'
        fill_in 'メールアドレス(※登録後は変更できません)', with: 'spring@example.com'
        fill_in 'user[password]', with: 'springshogakko'
        fill_in 'user[password_confirmation]', with: 'springshogakko'
        select '学校', from: 'user_position'
        click_button '登録する'

        expect(page).to have_http_status :ok
        expect(page).to have_text('スプリング小学校')
      end.to change(User, :count).by(1)
    end
  end

  feature 'Visit as loginuser' do
    before do
      sign_in_as user_school
      visit user_path(user_school)
    end

    scenario 'フォローページ' do
      click_link 'フォロー'
      expect(page).to have_http_status :ok
      expect(current_path).to eq follows_user_path(user_school)
      expect(page).to have_text('フォロー')
    end

    scenario 'フォロワーページ' do
      click_link 'フォロワー'
      expect(page).to have_http_status :ok
      expect(current_path).to eq followers_user_path(user_school)
      expect(page).to have_text('フォロワー')
    end

    scenario 'フォローリクエスト一覧ページ' do
      click_link 'フォローリクエスト一覧'
      expect(page).to have_http_status :ok
      expect(current_path).to eq user_requests_path(user_school)
      expect(page).to have_text('フォローリクエスト一覧')
    end
  end
end
