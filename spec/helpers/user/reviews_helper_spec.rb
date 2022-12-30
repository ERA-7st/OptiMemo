require 'rails_helper'

RSpec.describe User::ReviewsHelper, type: :helper do

  describe "update_day_subtraction" do
    context "差が0の場合" do
      example "文字列 今日 を返す" do
        expect(helper.update_day_subtraction(Time.zone.now)).to eq("今日")
      end
    end
    context "差が1〜31の場合" do
      example "文字列　(差分)日前 を返す" do
        min_day_after = Time.zone.now - 1.days
        expect(helper.update_day_subtraction(min_day_after)).to eq("1日前")
        max_days_after = Time.zone.now - 31.days
        expect(helper.update_day_subtraction(max_days_after)).to eq("31日前")
      end
    end
    context "差が32以上の場合" do
      example "文字列 一ヶ月以上前 を返す" do
        month_after = Time.zone.now - 32.days
        expect(helper.update_day_subtraction(month_after)).to eq("一ヶ月以上前")
      end
    end
  end

end
