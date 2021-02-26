require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#index' do
    before do
      @user = FactoryBot.create(:user_school)
    end

    context 'ログインユーザーとして' do
      it '正常にレスポンスを返すこと' do
        sign_in @user
        get :index
        expect(response).to be_success
      end
    end

    context 'ゲストとして' do
      it 'サインイン画面にリダイレクトすること' do
        get :index
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#show' do
    before do
      @user = FactoryBot.create(:user_school)
    end

    context 'ログインユーザーとして' do
      it '正常にレスポンスを返すこと' do
        sign_in @user
        get :show, params: { id: @user.id }
        expect(response).to be_success
      end
    end

    context 'ゲストとして' do
      it 'サインイン画面にリダイレクトすること' do
        get :show, params: { id: @user.id }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#follows' do
    before do
      @user = FactoryBot.create(:user_school)
    end

    context 'ログインユーザーとして' do
      it '正常にレスポンスを返すこと' do
        sign_in @user
        get :follows, params: { id: @user.id }
        expect(response).to be_success
      end
    end

    context 'ゲストとして' do
      it 'サインイン画面にリダイレクトすること' do
        get :follows, params: { id: @user.id }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#followers' do
    before do
      @user = FactoryBot.create(:user_school)
    end

    context 'ログインユーザーとして' do
      it '正常にレスポンスを返すこと' do
        sign_in @user
        get :followers, params: { id: @user.id }
        expect(response).to be_success
      end
    end

    context 'ゲストとして' do
      it 'サインイン画面にリダイレクトすること' do
        get :followers, params: { id: @user.id }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
end
