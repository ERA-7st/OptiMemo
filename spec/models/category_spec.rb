require 'rails_helper'

RSpec.describe Category, type: :model do

  let(:user)  { create(:user) }
  describe "バリデーション" do
    context "全ての値が正しい場合" do
      example "保存される" do
        expect(create(:category, user_id: user.id)).to be_valid
      end
    end
    describe "ユーザーID" do
      context "空の場合" do
        example "保存されない" do
          expect(build(:category)).to be_invalid
        end
      end
      context "存在しないユーザーIDの場合" do
        example "保存されない" do
          expect(build(:category, user_id: SecureRandom.uuid)).to be_invalid
        end
      end
    end
    describe "カテゴリー名" do
      let(:user2) { create(:user) }
      context "空の場合" do
        example "保存されない" do
          expect(user.categories.build(name: "")).to be_invalid
        end
      end
      context "21文字以上の場合" do
        example "保存されない" do
          expect(user.categories.build(name: "a" * 21 )).to be_invalid
        end
      end
      context "同一ユーザーのカテゴリー名重複" do
        example "保存されない" do
          category = create(:category, user_id: user.id)
          expect(build(:category, user_id: user.id)).to be_invalid
        end
      end
      context "異なるユーザーのカテゴリー名重複" do
        example "保存される" do
          category = create(:category, user_id: user.id)
          expect(build(:category, user_id: user2.id)).to be_valid
        end
      end
    end
  end

  describe "アソシエーション" do
    context "Userモデル" do
      example "N対1になっている" do
        expect(Category.reflect_on_association(:user).macro).to eq :belongs_to
      end
      example "親モデルと同時に削除される" do
        create(:category, user_id: user.id)
        expect{user.destroy}.to change { Category.count }.by(-1)
      end
    end
  end

  describe "メソッド" do
    context "ID" do
      example "ユニークな乱数になっている" do
        expect(build(:category, user_id: user.id).id).to_not eq 1
      end
    end
  end
end
