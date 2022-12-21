require File.expand_path(File.dirname(__FILE__) + "/environment")
ENV.each { |k, v| env(k, v) }
set :environment, :development

set :output, "#{Rails.root}/log/cron.log"

# every 1.day, at: '00:00 am' do
every 1.minute do
  begin
    rake "days_left:update"
  rescue => e
    raise e
  end
end

every 1.day, at: "12:00 pm" do
  begin
    rake "review_mail:send_email"
  rescue => e
    raise e
  end
end
