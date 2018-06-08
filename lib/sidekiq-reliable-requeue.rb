require 'sidekiq-reliable-requeue/redis_connection'
require 'sidekiq-reliable-requeue/middleware'
require 'sidekiq-reliable-requeue/worker'

module SidekiqReliableRequeue
  Sidekiq.default_worker_options = {
      requeue_timeout:  20,
      reliable_requeue: false
  }

  SidekiqReliableStaleJobsKey = 'sidekiq_tasks_being_performed'
end