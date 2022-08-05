module PeriodicMails
  extend ActiveSupport::Concern

    def set_week(week)
      week = current_user.periodic_mail[week]
      if week.nil?
        redirect_back(fallback_location: user_home_top_path)
      else
        week
      end
    end

  end