namespace :days_left do
  desc "days_left"
  task :update => :environment do
    Score.where("days_left >= ?",  1).each do |score|
      deducted_days_left = score.days_left - 1
      score.update!(days_left: deducted_days_left)
      # ログ
      logger = Logger.new("#{Rails.root}/log/cron.log")
      logger.error("ワードID：#{score.word_id}を更新")
    end
  end
end