require 'spec_helper'

describe SidekiqReliableRequeue::RedisConnection, redis: true do

  let(:redis_for_test) do
    Redis.new(REDIS_CONFIGURATION)
  end

  it('toto') do
    puts SidekiqReliableRequeue::RedisConnection.keys
  end

  it('should execute set') do
    random_key = 'tatat'
    SidekiqReliableRequeue::RedisConnection.set('tutu', random_key)
    expect(redis_for_test.get('tutu')).to eql('random_key')
  end

end