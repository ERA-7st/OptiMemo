namespace :review_mail do
  desc "review_mail"
  task :send_email => :environment do
    days = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"]
    users = User
      .eager_load(:periodic_mail)
      .where(send_mail: true, periodic_mail: { "#{days[Date.today.wday]}": true})
    if users.present?
      users.each do |user|
        words = user.words.eager_load(:score).where(score: { days_left: 0})
        if words.count > 0
          ReviewMailer.send_review_email(user,words.count).deliver
          # テスト
          logger = Logger.new("#{Rails.root}/log/cron.log")
          logger.error("#{user.name}へメールを送信")
        end
      end
    end
  end
end