module SidekiqReliableRequeue
  class Worker
    include Sidekiq::Worker

    def perform(key)
      data = RedisConnection.hget(SidekiqReliableStaleJobsKey, key)
      Sidekiq.logger.debug("Checking for data with key: #{key}")

      unless data
        Sidekiq.logger.debug("Job with key #{key} has been cleaned")
        return
      end

      sidekiq_msg = JSON.parse(RedisConnection.hget(SidekiqReliableStaleJobsKey, key))
      worker      = sidekiq_msg['class'].constantize

      Sidekiq.logger.info("Requeuing #{sidekiq_msg}")
      worker.client_push(sidekiq_msg.except('jid'))
      RedisConnection.hdel(SidekiqReliableStaleJobsKey, key)
    end

    def requeue_stale_jobs
      keys = RedisConnection.hkeys(SidekiqReliableStaleJobsKey)

      if keys.empty?
        Sidekiq.logger.info('No stale jobs to add')
      end

      keys.each do |key|
        data = RedisConnection.hget(SidekiqReliableStaleJobsKey, key)
        next unless data

        sidekiq_msg = JSON.parse(RedisConnection.hget(SidekiqReliableStaleJobsKey, key))

        Sidekiq.logger.info("Preparing job #{key} to be requeued in #{sidekiq_msg['requeue_timeout']}s")
        Worker.perform_in(sidekiq_msg['requeue_timeout'], key)
      end
    end
  end
end