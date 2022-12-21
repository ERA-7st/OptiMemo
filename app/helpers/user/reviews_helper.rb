module User::ReviewsHelper

  def updat_day_subtraction(updated_at)
    past_seconds = Time.zone.now - updated_at
    pastdays = (past_seconds / 1.days).floor
    case pastdays
    when 0
      "今日"
    when 1 .. 31
      "#{pastdays}日前"
    else
      "一ヶ月以上前"
    end
  end

end
