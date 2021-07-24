require 'redis-rails'

uri = URI.parse(ENV["REDIS"])
REDIS = Redis.new(host: ENV["REDIS_HOST"], port: uri.port)