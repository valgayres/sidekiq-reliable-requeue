Gem::Specification.new do |gem|
  gem.name        = 'sidekiq-reliable-requeue'
  gem.version     = '0.5.0'
  gem.date        = '2018-06-07'
  gem.summary     = 'Sidekiq middleware to handle requeuing of jobs if the worker gets badly terminated or crashes'
  gem.authors     = ['Vincent Algayres']
  gem.files       = [
      'lib/sidekiq-reliable-requeue.rb',
      'lib/sidekiq-reliable-requeue/redis_connection.rb',
      'lib/sidekiq-reliable-requeue/middleware.rb',
      'lib/sidekiq-reliable-requeue/worker.rb'
  ]

  gem.license       = 'MIT'

  gem.add_dependency 'sidekiq', '>= 2.0'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end