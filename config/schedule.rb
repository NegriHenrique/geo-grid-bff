set :output, "log/cron.log"
set :environment, ENV["RAILS_ENV"] || "development"

if fetch(:environment) == "production"
  every 1.day, at: "00:00 am" do
    command "cd #{fetch(:path)} && bundle exec rails runner -e #{fetch(:environment)} 'GameCreationJob.perform_later'"
  end
end
