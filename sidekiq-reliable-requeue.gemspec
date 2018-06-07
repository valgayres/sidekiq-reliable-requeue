Gem::Specification.new do |s|
  s.name        = 'sidekiq-reliable-requeue'
  s.version     = '0.1.0'
  s.date        = '2018-06-07'
  s.summary     = 'Sidekiq middleware to handle requeuing of jobs if the worker gets badly terminated or crashes'
  s.authors     = ['Vincent Algayres']
  s.files       = [
      'lib/sidekiq_reliable_requeue.rb',
      'lib/sidekiq_reliable_requeue/redis_connection.rb',
      'lib/sidekiq_reliable_requeue/middleware.rb',
      'lib/sidekiq_reliable_requeue/worker.rb'
  ]
  s.license       = 'MIT'
end