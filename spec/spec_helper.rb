require 'rspec'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'sidekiq-reliable-requeue'


Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

