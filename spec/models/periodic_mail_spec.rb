require 'rails_helper'

RSpec.describe PeriodicMail, type: :model do

  describe "バリデーション" do
    describe "ユーザーID" do
      context "存在する場合" do
        example "保存される" do
          user = create(:user)
          expect(PeriodicMail.create(user_id: user.id)).to be_valid
        end
      end
      context "空の場合" do
        example "保存されない" do
          expect(PeriodicMail.create).to be_invalid
        end
      end
      context "存在しないユーザーIDの場合" do
        example "保存されない" do
          expect(PeriodicMail.create(user_id: SecureRandom.uuid)).to be_invalid
        end
      end
    end
  end

  describe "値" do
    example "真偽値が正しく保存されている" do
      user = create(:user)
      periodic_mail = PeriodicMail.create(user_id: user.id)
      expect(periodic_mail.sun).to eq true
      expect(periodic_mail.mon).to eq false
      expect(periodic_mail.tue).to eq false
      expect(periodic_mail.wed).to eq false
      expect(periodic_mail.thu).to eq false
      expect(periodic_mail.fri).to eq false
      expect(periodic_mail.sat).to eq false
    end
  end

  describe "アソシエーション" do
    context "Userモデル" do
      example "1:1になっている" do
        expect(PeriodicMail.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end

end
