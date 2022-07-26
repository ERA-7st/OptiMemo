require File.expand_path(File.dirname(__FILE__) + "/environment")
ENV.each { |k, v| env(k, v) }
set :environment, :development

set :output, "#{Rails.root}/log/cron.log"

every 1.day, at: '00:00 am' do
  begin
    rake "days_left:update"
  rescue => e
    raise e
  end
end
