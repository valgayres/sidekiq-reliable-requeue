require 'spec_helper'
require 'securerandom'

describe SidekiqReliableRequeue::RedisConnection, redis: true do

  let(:redis_for_test) do
    Redis.new(REDIS_CONFIGURATION)
  end

  it('should execute set') do
    random_key    = SecureRandom.hex
    random_value  = SecureRandom.hex
    SidekiqReliableRequeue::RedisConnection.set(random_key, random_value)
    expect(redis_for_test.get(random_key)).to eql(random_value)
  end

  it('should execute get') do
    random_key    = SecureRandom.hex
    random_value  = SecureRandom.hex
    redis_for_test.set(random_key, random_value)
    expect(SidekiqReliableRequeue::RedisConnection.get(random_key)).to eql(random_value)
  end

  it('should execute hset commands') do
    random_key    = SecureRandom.hex
    random_value1 = SecureRandom.hex
    random_value2 = SecureRandom.hex

    SidekiqReliableRequeue::RedisConnection.hset(random_key, 1, random_value1)
    SidekiqReliableRequeue::RedisConnection.hset(random_key, 2, random_value2)

    expect(redis_for_test.hget(random_key, 1)).to eql(random_value1)
    expect(redis_for_test.hget(random_key, 2)).to eql(random_value2)
  end

  it('should execute hget commands') do
    random_key    = SecureRandom.hex
    random_value1 = SecureRandom.hex
    random_value2 = SecureRandom.hex

    redis_for_test.hset(random_key, 1, random_value1)
    redis_for_test.hset(random_key, 2, random_value2)

    expect(SidekiqReliableRequeue::RedisConnection.hget(random_key, 1)).to  eql(random_value1)
    expect(SidekiqReliableRequeue::RedisConnection.hget(random_key, 2)).to  eql(random_value2)
    expect(SidekiqReliableRequeue::RedisConnection.hkeys(random_key)).to    eql(%w(1 2))
    expect(SidekiqReliableRequeue::RedisConnection.hvals(random_key)).to    eql([random_value1, random_value2])
    expect(SidekiqReliableRequeue::RedisConnection.hlen(random_key)).to     eql(2)
  end

end