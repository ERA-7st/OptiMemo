require 'rails_helper'

RSpec.describe Score, type: :model do

  let(:user) { create(:user) }
  let(:word) { create(:word, user_id: user.id) }

  describe "バリデーション" do
    context "全ての値が正しい場合" do
      example "保存される" do
        expect(Score.new(word_id: word.id)).to be_valid
      end
    end
    describe "ワードID" do
      context "空の場合" do
        example "保存されない" do
          expect(Score.new).to be_invalid
        end
      end
      context "存在しないワードIDの場合" do
        example "保存されない" do
          expect(Score.new(word_id: SecureRandom.uuid)).to be_invalid
        end
      end
      context "重複" do
        example "保存されない" do
          Score.create(word_id: word.id)
          expect(Score.new(word_id: word.id)).to be_invalid
        end
      end
    end
    describe "正答回数" do
      context "空の場合" do
        example "保存されない" do
          expect(Score.new(word_id: word.id, correct_count: "")).to be_invalid
        end
      end
      context "少数の場合" do
        example "保存されない" do
          expect(Score.new(word_id: word.id, correct_count: 0.1)).to be_invalid
        end
      end
      context "負の数の場合" do
        example "保存されない" do
          expect(Score.new(word_id: word.id, correct_count: -1)).to be_invalid
        end
      end
    end
    describe "誤答回数" do
      context "空の場合" do
        example "保存されない" do
          expect(Score.new(word_id: word.id, wrong_count: "")).to be_invalid
        end
      end
      context "少数の場合" do
        example "保存されない" do
          expect(Score.new(word_id: word.id, wrong_count: 0.1)).to be_invalid
        end
      end
      context "負の数の場合" do
        example "保存されない" do
          expect(Score.new(word_id: word.id, wrong_count: -1)).to be_invalid
        end
      end
    end
    describe "フェーズ" do
      context "空の場合" do
        example "保存されない" do
          expect(Score.new(word_id: word.id, phase: "")).to be_invalid
        end
      end
      context "少数の場合" do
        example "保存されない" do
          expect(Score.new(word_id: word.id, phase: 0.1)).to be_invalid
        end
      end
      context "負の数の場合" do
        example "保存されない" do
          expect(Score.new(word_id: word.id, phase: -1)).to be_invalid
        end
      end
    end
    describe "残り日数" do
      context "空の場合" do
        example "保存されない" do
          expect(Score.new(word_id: word.id, days_left: "")).to be_invalid
        end
      end
      context "少数の場合" do
        example "保存されない" do
          expect(Score.new(word_id: word.id, days_left: 0.1)).to be_invalid
        end
      end
      context "負の数の場合" do
        example "保存されない" do
          expect(Score.new(word_id: word.id, days_left: -1)).to be_invalid
        end
      end
    end
  end

  describe "値" do
    example "デフォルト数値が正しく保存されている" do
      score = Score.create(word_id: word.id)
      expect(score.correct_count).to eq 0
      expect(score.wrong_count).to eq 0
      expect(score.phase).to eq 0
      expect(score.days_left).to eq 1
    end
  end

  describe "アソシエーション" do
    context "Wordモデル" do
      example "1対1になっている" do
        expect(Score.reflect_on_association(:word).macro).to eq :belongs_to
      end
      example "親モデルと同時に削除される" do
        Score.create(word_id: word.id)
        expect{word.destroy}.to change {Score.count}.by(-1)
      end
    end
  end

  describe "メソッド" do
    context "ID" do
      example "ユニークな乱数になっている" do
        expect(build(:score, word_id: word.id).id).to_not eq 1
      end
    end
  end

end
