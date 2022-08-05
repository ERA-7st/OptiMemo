class User::PeriodicMailsController < ApplicationController

  include PeriodicMails

  before_action :user_logged_in?

  def edit
    @weeks = ["sun","mon","tue","wed","thu","fri","sat"]
  end

  def edit_send_mail
    current_user.send_mail == true ? changed_send_mail = false : changed_send_mail = true
    current_user.update(send_mail: changed_send_mail)
    render turbo_stream: turbo_stream.replace(
      "change_send_mail",
      partial: 'user/periodic_mails/edit_send_mail'
    )
  end

  def update
    send_mail = ( set_week(params[:week]) == true ? false : true )  # set_week -> concerns/periodic_mails.rb
    current_user.periodic_mail.update("#{params[:week]}": send_mail)
    render turbo_stream: turbo_stream.replace(
      "change_periodic_mail_#{params[:week]}",
      partial: 'user/periodic_mails/edit',
      locals: { week: params[:week]}
    )
  end


end
