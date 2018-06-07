require 'sidekiq_reliable_requeue/redis_connection'
require 'sidekiq_reliable_requeue/middleware'
require 'sidekiq_reliable_requeue/worker'

module SidekiqReliableRequeue
  Sidekiq.default_worker_options = {
      requeue_timeout:  20,
      reliable_requeue: false
  }

  SidekiqReliableStaleJobsKey = 'sidekiq_tasks_being_performed'
end