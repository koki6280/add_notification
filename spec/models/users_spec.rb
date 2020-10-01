require 'rails_helper'

RSpec.describe 'Userモデル', type: :model do
  describe 'バリデーション' do
    subject { user.valid? }

    let(:user) { create(:user) }

    it '作成できること' do
      is_expected.to eq true
    end

    context 'nickname' do
      it '空欄でないこと' do
        user.nickname = ''
        is_expected.to eq false
      end

      it "20文字以内であること" do
        user.nickname = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context 'profile' do
      it '50文字以下であること' do
        user.profile = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Diaryモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:diaries).macro).to eq :has_many
        expect(User.reflect_on_association(:favorite_diaries).macro).to eq :has_many
      end
    end

    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'Relationshipモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:follower).macro).to eq :has_many
        expect(User.reflect_on_association(:followed).macro).to eq :has_many
      end
    end

    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:active_notifications).macro).to eq :has_many
        expect(User.reflect_on_association(:passive_notifications).macro).to eq :has_many
      end
    end

    context 'Entryモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:entries).macro).to eq :has_many
      end
    end

    context 'Messageモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:messages).macro).to eq :has_many
      end
    end
  end
end
