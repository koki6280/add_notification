require 'rails_helper'

RSpec.describe '表示のテスト', type: :feature do
  let(:current_user) { create(:user) }
  let(:diary) { create(:diary, user_id: current_user.id) }
  subject { page }
  
  before do
    visit new_user_session_path
  end

context '会員登録' do
  it 'ログインしていなければ表示される' do
    is_expected.to have_link '会員登録'
  end
  it 'ログインしていれば表示されない' do
    login(current_user)
    is_expected.not_to have_link '会員登録'
  end
end



end