
Sidekiq.configure_server do |config|
  config.redis = { url: "redis://redis:6379" }

  config.on(:startup) do
    Sidekiq::Cron::Job.load_from_hash YAML.load_file("config/schedule.yml")
    Sidekiq::Scheduler.reload_schedule!
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://redis:6379" }
end
