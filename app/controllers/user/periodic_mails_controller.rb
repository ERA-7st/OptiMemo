class User::PeriodicMailsController < ApplicationController

  before_action :user_logged_in?

  def edit

  end

  def edit_send_mail
    current_user.send_mail == true ? changed_send_mail = false : changed_send_mail = true
    current_user.update(send_mail: changed_send_mail)
    render turbo_stream: turbo_stream.replace(
      "change_send_mail",
      partial: 'user/periodic_mails/edit_send_mail'
    )
  end

end
