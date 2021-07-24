require 'redis-rails'

REDIS = Redis.new(host: ENV['REDIS_HOST'], port: ENV['REDIS_PORT'])