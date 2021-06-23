require 'sidekiq/api'

redis_config = {:driver => :hiredis, url: (ENV["REDISTOGO_URL"] || "redis://redis:6379") }

Sidekiq.configure_server do |config|
  config.redis = redis_config
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end

Sidekiq.logger.level = Logger::WARN if Rails.env.production?
