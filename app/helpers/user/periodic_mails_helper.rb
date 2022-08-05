module User::PeriodicMailsHelper

  def week_button_text(week)
    if current_user.periodic_mail[week] == true
      "ON"
    else
      "OFF"
    end
  end

end
