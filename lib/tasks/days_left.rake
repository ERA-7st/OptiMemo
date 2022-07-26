namespace :days_left do
  task :update => :environment do
    Score.where("days_left >= ?",  1).each do |score|
      deducted_days_left = score.days_left - 1
      score.update!(days_left: deducted_days_left)
    end
  end
end