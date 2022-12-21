require 'rails_helper'

RSpec.describe User::PeriodicMailsHelper, type: :helper do

  let(:user) { create(:user) }
  let!(:periodic_mail) { create(:periodic_mail, user_id: user.id) }

  before do
    allow(helper).to receive(:current_user).and_return(user)
  end

  describe "week_button_text" do
    context "メール受け取りがtrueの場合" do
      example "文字列 ON を返す" do
        expect(helper.week_button_text("sun")).to eq("ON")
      end
    end
    context "メール受け取りがfalseの場合" do
      example "文字列 OFF を返す" do
        expect(helper.week_button_text("mon")).to eq("OFF")
      end
    end
  end

end
