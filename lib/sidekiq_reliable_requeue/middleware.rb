module SidekiqReliableRequeue
  class Middleware

    def call(worker, msg, queue)
      if msg['reliable_requeue']
        set_stale_info(msg)
      end
      yield
    ensure
      clean_stale_info
    end

    def set_stale_info(msg)
      @redis_key_for_check = "#{msg['class']}:#{msg['jid']}"
      RedisConnection.hset(SidekiqReliableStaleJobsKey, @redis_key_for_check, msg.to_json)
    end

    def clean_stale_info
      RedisConnection.hdel(SidekiqReliableStaleJobsKey, @redis_key_for_check)
    end
  end
end