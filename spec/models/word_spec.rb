require 'rails_helper'

RSpec.describe Word, type: :model do

  let(:user) { create(:user) }
  describe "バリデーション" do
    context "全ての値が正しい場合" do
      example "保存される" do
        expect(create(:word, user_id: user.id)).to be_valid
      end
    end
    describe "ユーザーID" do
      context "空の場合" do
        example "保存されない" do
          expect(build(:word)).to be_invalid
        end
      end
      context "存在しないユーザーIDの場合" do
        example "保存されない" do
          expect(build(:word, user_id: SecureRandom.uuid)).to be_invalid
        end
      end
    end
    describe "単語名" do
      let(:user2) { create(:user) }
      context "空の場合" do
        example "保存されない" do
          expect(user.words.build(content: "test", word: "")).to be_invalid
        end
      end
      context "21文字以上の場合" do
        example "保存されない" do
          expect(user.words.build(content: "test", word: "a" * 21)).to be_invalid
        end
      end
      context "同一ユーザーの単語名重複" do
        example "保存されない" do
          word = create(:word, user_id: user.id)
          expect(build(:word, user_id: user.id)).to be_invalid
        end
      end
      context "異なるユーザーの単語名重複" do
        example "保存される" do
          word = create(:word, user_id: user.id)
          expect(build(:word, user_id: user2.id)).to be_valid
        end
      end
    end
    describe "コンテンツ" do
      context "空の場合" do
        example "保存されない" do
          expect(user.words.build(content: "", word: "a" * 20)).to be_invalid
        end
      end
    end
  end

  describe "アソシエーション" do
    context "Userモデル" do
      example "N対1になっている" do
        expect(Word.reflect_on_association(:user).macro).to eq :belongs_to
      end
      example "親モデルと同時に削除される" do
        create(:word, user_id: user.id)
        expect{user.destroy}.to change { Word.count }.by(-1)
      end
    end
  end

  describe "メソッド" do
    context "ID" do
      example "ユニークな乱数になっている" do
        expect(build(:word, user_id: user.id).id).to_not eq 1
      end
    end
  end

end
