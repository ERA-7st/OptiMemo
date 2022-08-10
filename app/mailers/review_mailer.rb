class ReviewMailer < ApplicationMailer
  
  def send_review_email(user,count)
    @user = user
    @count = count
    @date = Date.current.strftime("%Y/%m/%d")
    mail to: user.email, subject: '復習'
  end

end
