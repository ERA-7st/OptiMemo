require 'rails_helper'

RSpec.describe PeriodicMail, type: :model do

  let(:user) { create(:user) }
  describe "バリデーション" do
    context "全ての値が正しい場合" do
      example "保存される" do
        expect(PeriodicMail.create(user_id: user.id)).to be_valid
      end
    end
    describe "ユーザーID" do
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
      example "親モデルと同時に削除される" do
        PeriodicMail.create(user_id: user.id)
        expect{user.destroy}.to change { PeriodicMail.count }.by(-1)
      end
    end
  end

  describe "メソッド" do
    context "ID" do
      example "ユニークな乱数になっている" do
        expect(build(:periodic_mail, user_id: user.id).id).to_not eq 1
      end
    end
  end

end
