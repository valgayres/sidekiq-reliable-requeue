require 'sidekiq/util'
Sidekiq.logger.level = Logger::ERROR

REDIS_CONFIGURATION = {
    url:        'redis://127.0.0.1:6379/15', # using last redis db for local test
}

Sidekiq.redis = REDIS_CONFIGURATION

def redis_cleaner
  @redis_cleaner ||= Redis.new(REDIS_CONFIGURATION)
end

def with_clean_redis(&block)
  redis_cleaner.flushdb   # clean before run
  begin
    yield
  ensure
    redis_cleaner.flushdb # clean up after run
  end
end

RSpec.configure do |spec|

  # clean the Redis database around each run
  # @see https://www.relishapp.com/rspec/rspec-core/docs/hooks/around-hooks
  puts 'Initializing redis'
  spec.around(:each, redis: true) do |example|
    #with_clean_redis do
      example.run
    #end
  end
end