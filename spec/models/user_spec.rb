require "rails_helper"

RSpec.describe User, type: :model do

  describe "バリデーション" do
    context "値が全て存在する場合" do
      example "保存される" do
        expect(create(:user)).to be_valid
      end
    end
    describe "ユーザー名" do
      context "空の場合" do
        example "保存されない" do
          expect(build(:user, name: "")).to be_invalid
        end
      end
      context "11文字以上の場合" do
        example "保存されない" do
          expect(build(:user, name: "a" * 11 )).to be_invalid 
        end
      end
    end
    describe "メールアドレス" do
      context "空の場合" do
        example "保存されない" do
          expect(build(:user, email: "")).to be_invalid
        end
      end
      context "重複している場合" do
        example "保存されない" do
          user1 = create(:user)
          expect(build(:user, email: user1.email)).to be_invalid
        end
      end
    end
    describe "パスワード" do
      context "空の場合" do
        example "保存されない" do
          expect(build(:user, password: "")).to be_invalid
        end
      end
      context "password_confirmationとpasswordが異なる場合" do
        example "保存されない" do
          expect(build(:user, password_confirmation: "passward")).to be_invalid 
        end
      end
    end
  end

  describe "アソシエーション" do
    context "PeriodicMailモデル" do
      example "1:1になっている" do
        expect(User.reflect_on_association(:periodic_mail).macro).to eq :has_one
      end
    end
  end

end