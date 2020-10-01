require 'rails_helper'

RSpec.describe '表示のテスト', type: :feature do
  subject { page }

  let(:current_user) { create(:user) }
  let(:diary) { create(:diary, user_id: current_user.id) }

  before do
    visit new_user_session_path
  end

  context '会員登録リンク' do
    it 'ログインしていなければ表示される' do
      is_expected.to have_link '会員登録'
    end
    it 'ログインしていれば表示されない' do
      login(current_user)
      is_expected.not_to have_link '会員登録'
    end
  end

  context 'ログインリンク' do
    it 'ログインしていなければ表示される' do
      is_expected.to have_link 'ログイン'
    end
    it 'ログインしていれば表示されない' do
      login(current_user)
      is_expected.not_to have_link 'ログイン'
    end
  end

  context 'マイページリンク' do
    it 'ログインしていれば表示される' do
      login(current_user)
      is_expected.to have_link 'マイページ'
    end
    it 'ログインしていなければ表示されない' do
      is_expected.not_to have_link 'マイページ'
    end
  end

  context '新規投稿リンク' do
    it 'ログインしていれば表示される' do
      login(current_user)
      is_expected.to have_link '新規投稿'
    end
    it 'ログインしていなければ表示されない' do
      is_expected.not_to have_link '新規投稿'
    end
  end
end
