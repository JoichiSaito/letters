require 'rails_helper'

RSpec.feature 'Requests', type: :feature do
  scenario 'フォローリクエストボタンを押す', js: true do
    visit root_path
    click_link '新規登録'
    fill_in 'user[name]', with: 'フェニックス小学校'
    fill_in 'メールアドレス(※登録後は変更できません)', with: 'phoenix@example.com'
    fill_in 'user[password]', with: 'phoenixshogakko'
    fill_in 'user[password_confirmation]', with: 'phoenixshogakko'
    check 'アカウントを非公開にする'
    select '学校', from: 'user_position'
    click_button '登録する'
    click_link 'ログアウト'

    visit root_path
    user = FactoryBot.create(:user_parent)
    sign_in_as user

    visit users_path
    click_link 'フェニックス小学校'

    expect(page).to have_content 'リクエスト送信'
    click_link 'リクエスト送信'

    expect(page).to have_content 'リクエスト取消'
  end
end
