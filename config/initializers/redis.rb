require 'redis-rails'

REDIS = Redis.new(host: "redis", port: 6379, db: 0)