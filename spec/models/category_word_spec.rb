require 'rails_helper'

RSpec.describe CategoryWord, type: :model do

  let(:user) { create(:user) }
  let(:category) { create(:category, user_id: user.id) }
  let(:word) { create(:word, user_id: user.id) }

  describe "バリデーション" do
    context "全ての値が正しい場合" do
      example "保存される" do
        expect(CategoryWord.new(category_id: category.id, word_id: word.id)).to be_valid
      end
    end
    context "重複保存" do
      example "保存されない" do
        CategoryWord.create(category_id: category.id, word_id: word.id)
        expect(CategoryWord.new(category_id: category.id, word_id: word.id)).to be_invalid
      end
    end
    describe "カテゴリーID" do
      context "空の場合" do
        example "保存されない" do
          expect(CategoryWord.new(category_id: "", word_id: word.id)).to be_invalid
        end
      end
      context "存在しないカテゴリーIDの場合" do
        example "保存されない" do
          expect(CategoryWord.new(category_id: SecureRandom.uuid,word_id: word.id)).to be_invalid
        end
      end
    end
    describe "ワードID" do
      context "空の場合" do
        example "保存されない" do
          expect(CategoryWord.new(category_id: category.id, word_id: "")).to be_invalid
        end
      end
      context "存在しないワードIDの場合" do
        example "保存されない" do
          expect(CategoryWord.new(category_id: category.id, word_id: SecureRandom.uuid)).to be_invalid
        end
      end
    end
  end

  describe "アソシエーション" do
    let!(:category_word) { CategoryWord.create(category_id: category.id, word_id: word.id) }
    context "Categoryモデル" do
      example "N対1になっている" do
        expect(CategoryWord.reflect_on_association(:category).macro).to eq :belongs_to
      end
      example "親モデルと同時に削除される" do
        expect{category.destroy}.to change {CategoryWord.count}.by(-1)
      end
    end
    context "Wordモデル" do
      example "N対1になっている" do
        expect(CategoryWord.reflect_on_association(:word).macro).to eq :belongs_to
      end
      example "親モデルと同時に削除される" do
        expect{word.destroy}.to change {CategoryWord.count}.by(-1)
      end
    end
  end

  describe "メソッド" do
    context "ID" do
      example "ユニークな乱数になっている" do
        expect(CategoryWord.new(category_id: category.id, word_id: word.id).id).to_not eq 1
      end
    end
  end

end
