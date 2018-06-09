require 'sidekiq'
require 'sidekiq-reliable-requeue/redis_connection'
require 'sidekiq-reliable-requeue/middleware'
require 'sidekiq-reliable-requeue/worker'

module SidekiqReliableRequeue
  Sidekiq.default_worker_options = {
      requeue_timeout:  20,
      reliable_requeue: false
  }

  SidekiqReliableStaleJobsKey = 'sidekiq_tasks_being_performed'

  def self.initialize(requeue_timeout: 20, reliable_requeue: false)
    Sidekiq.default_worker_options = {
        requeue_timeout:  requeue_timeout,
        reliable_requeue: reliable_requeue
    }

    Sidekiq.configure_server do |config|
      config.on(:startup) do
        Worker.requeue_stale_jobs
      end

      config.server_middleware do |chain|
        chain.add Middleware
      end
    end
  end
end