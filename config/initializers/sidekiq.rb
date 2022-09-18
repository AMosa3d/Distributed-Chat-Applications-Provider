
Sidekiq.configure_server do |config|
  config.redis = { url: "redis://redis:6379/0" }

  config.on(:startup) do
    Sidekiq::Cron::Job.load_from_hash YAML.load_file("config/schedule.yml")
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://redis:6379/0" }
end
