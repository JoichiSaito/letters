require 'rails_helper'

RSpec.describe BoardsController, type: :controller do
  let(:user_school) { FactoryBot.create(:user_school) }
  let(:user_school2) { FactoryBot.create(:user_school2) }
  let(:user_parent) { FactoryBot.create(:user_parent) }
  let(:board_1) { FactoryBot.create(:board_1, user_id: user_school.id) }

  describe '#new' do    
    context 'ログインユーザー(学校)として' do
      it '正常にレスポンスを返すこと' do
        sign_in user_school
        get :new
        expect(response).to be_success
      end
    end

    context 'ログインユーザー(保護者)として' do
      it 'トップページにリダイレクトすること' do
        sign_in user_parent
        get :new
        expect(response).to redirect_to root_path
      end
    end

    context 'ゲストとして' do
      it 'サインイン画面にリダイレクトすること' do
        get :new
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#create' do
    context 'ログインユーザー(学校)として' do
      it 'お知らせを作成できること' do
        sign_in user_school
        expect{
          post :create, params: { 
            board: {
              user_id: 1,
              title: '除草作業のお知らせ',
              content: '除草作業のお知らせ',
              quetionnaire: true
            } 
          }
        }.to change(Board, :count).by(1)
      end

      it 'お知らせ作成後に作成したお知らせの詳細ページへリダイレクトされること' do
        sign_in user_school
        post :create, params: { 
          board: {
            user_id: 1,
            title: '除草作業のお知らせ',
            content: '除草作業のお知らせ',
            quetionnaire: true
          } 
        }
        expect(response).to redirect_to(Board.last)
      end

      it "不正なお知らせは作成できないこと" do
        sign_in user_school
        expect {
          post :create, params: {
            board: {
              user_id: 1,
              title: nil,
              content: "除草作業のお知らせ",
              quetionnaire: true
            }
          }
        }.to_not change(Board, :count)
      end

      it '不正なお知らせを作成すると、再度作成ページへリダイレクトされること' do
        sign_in user_school
        post :create, params: { 
          board: {
            user_id: 1,
            title: nil,
            content: '除草作業のお知らせ',
            quetionnaire: true
          } 
        }
        expect(response).to redirect_to '/boards/new'
      end
    end

    context 'ログインユーザー(保護者)として' do
      it 'トップページにリダイレクトすること' do
        sign_in user_parent
        get :create
        expect(response).to redirect_to root_path
      end
    end
  
    context 'ゲストとして' do
      it 'サインイン画面にリダイレクトすること' do
        get :create
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#edit' do    
    context 'ログインユーザー(学校)として' do
      it '正常にレスポンスを返すこと' do
        sign_in user_school
        get :edit, params: { id: board_1.id }
        expect(response).to be_success
      end

      it '他の学校がお知らせを編集しようとしたらトップページにリダイレクトすること' do
        sign_in user_school2
        get :edit, params: { id: board_1.id }
        expect(response).to redirect_to root_path
      end
    end

    context 'ログインユーザー(保護者)として' do
      it 'トップページにリダイレクトすること' do
        sign_in user_parent
        get :edit, params: { id: board_1.id }
        expect(response).to redirect_to root_path
      end
    end

    context 'ゲストとして' do
      it 'サインイン画面にリダイレクトすること' do
        get :edit, params: { id: board_1.id }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe "#update" do
    context "ログインユーザー(学校)として" do
      it "正常に記事を更新できること" do
        sign_in user_school
        board_params = {title: "テスト"}
        patch :update, params: {id: board_1.id, board: board_params}
        expect(board_1.reload.title).to eq "テスト"
      end

      it "記事を更新した後、更新された記事の詳細ページへリダイレクトすること" do
        sign_in user_school
        board_params = {title: "テスト"}
        patch :update, params: {id: board_1.id, board: board_params}
        expect(response).to redirect_to(Board.last)
      end

      it "不正なアトリビュートを含むお知らせは更新できないこと" do
        sign_in user_school
        board_params = {title: nil}
        patch :update, params: {id: board_1.id, board: board_params}
        expect(board_1.reload.title).to eq "懇談会のお知らせ"
      end

      it "不正なお知らせを更新しようとすると、再度更新ページへリダイレクトされること" do
        sign_in user_school
        board_params = {title: nil}
        patch :update, params: {id: board_1.id, board: board_params}
        expect(response).to redirect_to(Board.last)
      end

      it '他の学校がお知らせを更新しようとしたらトップページにリダイレクトすること' do
        sign_in user_school2
        board_params = {title: "テスト"}
        patch :update, params: {id: board_1.id, board: board_params}
        expect(response).to redirect_to root_path
      end
    end

    context 'ログインユーザー(保護者)として' do
      it 'トップページにリダイレクトすること' do
        sign_in user_parent
        board_params = {
          user_id: 1,
          title: "テスト",
          content: "テスト",
          questionnaire: true
        }
        patch :update, params: {id: board_1.id, board: board_params}
        expect(response).to redirect_to root_path
      end
    end
  
    context 'ゲストとして' do
      it 'サインイン画面にリダイレクトすること' do
        board_params = {
          user_id: 1,
          title: "テスト",
          content: "テスト",
          questionnaire: true
        }
        patch :update, params: {id: board_1.id, board: board_params}
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe "#destroy" do
    context "ログインユーザー(学校)として" do
      it "正常に記事を削除できること" do
        sign_in user_school
        expect {
          delete :destroy, params: {id: board_1.id}
        }.to change(Board, :count).by(0)
      end

      it "記事を削除した後、マイページへリダイレクトされること" do
        sign_in user_school
        delete :destroy, params: {id: board_1.id}
        expect(response).to redirect_to user_path(user_school)
      end

      it "お知らせを作成したユーザー以外は、記事を削除できないこと" do
        sign_in user_school2
        @another_board = user_school.boards.create(
          user_id: 1,
          title: "テスト",
          content: "テスト",
          questionnaire: true
        )
        expect {
          delete :destroy, params: {id: @another_board.id}
        }.to_not change(user_school.boards, :count)
      end

      it "お知らせを作成したユーザー以外が記事を削除しようとするとトップページにリダイレクトすること" do
        sign_in user_school2
        @another_board = user_school.boards.create(
          user_id: 1,
          title: "テスト",
          content: "テスト",
          questionnaire: true
        )
        delete :destroy, params: {id: @another_board.id}
        expect(response).to redirect_to root_path
      end
    end

    context "ログインユーザー(保護者)として" do
      it "トップページにリダイレクトされること" do
        sign_in user_parent
        delete :destroy, params: {id: board_1.id}
        expect(response).to redirect_to root_path
      end
    end

    context 'ゲストとして' do
      it 'サインイン画面にリダイレクトすること' do
        delete :destroy, params: {id: board_1.id}
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
end
