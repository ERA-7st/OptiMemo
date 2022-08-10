namespace :review_mail do
  task :send_email => :environment do
    days = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"]
    users = User
      .eager_load(:periodic_mail)
      .where(send_mail: true, periodic_mail: { "#{days[Date.today.wday]}": true})
    if users.present?
      users.each do |user|
        words = user.words.eager_load(:score).where(score: { days_left: 0})
        if words
          ReviewMailer.send_review_email(user,words.count).deliver
        end
      end
    end
  end
end