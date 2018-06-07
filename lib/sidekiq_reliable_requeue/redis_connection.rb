module SidekiqReliableRequeue
  class RedisConnection
    class << self
      def method_missing(redis_method, *args)
        Sidekiq.redis do |conn|
          conn.send(redis_method, *args)
        end
      end
    end
  end
end