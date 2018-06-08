Gem::Specification.new do |s|
  s.name        = 'sidekiq-reliable-requeue'
  s.version     = '0.1.0'
  s.date        = '2018-06-07'
  s.summary     = 'Sidekiq middleware to handle requeuing of jobs if the worker gets badly terminated or crashes'
  s.authors     = ['Vincent Algayres']
  s.files       = [
      'lib/sidekiq-reliable-requeue.rb',
      'lib/sidekiq-reliable-requeue/redis_connection.rb',
      'lib/sidekiq-reliable-requeue/middleware.rb',
      'lib/sidekiq-reliable-requeue/worker.rb'
  ]
  s.license       = 'MIT'
end