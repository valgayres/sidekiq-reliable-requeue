# sidekiq-reliable-requeue

[![Build Status](https://travis-ci.org/valgayres/sidekiq-reliable-requeue.svg)](https://travis-ci.org/valgayres/sidekiq-reliable-requeue)

SidekiqReliableRequeue is a sidekiq middleware to handle requeuing of jobs if the worker gets badly terminated or crashes.


## Compatibility

SidekiqReliableRequeue supports Sidekiq from version 2 and Ruby from version 2.0.0.

Warning, SidekiqReliableRequeue will only work when Sidekiq is used with Redis as datastore.

## Installation

As always, you can either install the gem outside a Gemfile app :

    $ gem install sidekiq-throttler

or just add this line to your application's Gemfile:

```ruby
gem 'sidekiq-reliable-requeue'
```

and then execute:

    $ bundle install


## How it works

`SidekiqReliableRequeue` allows requeuing of Sidekiq jobs when Sidekiq terminates in a non regular way.

By default, Sidekiq allows to requeue long jobs being perform during a restart, if it receives a SIGTERM signal.
Unfortunately, sometimes, this process doesn't work.

This can happen in several case, for example is Sidekiq gets out of memory and swaps a lot, in which case it may not have
the time to requeue its jobs, or if the redis connection is lost.


In order to prevent the lost of jobs, we add to the Sidekiq middleware chain a new handler that will add the jobs getting
processed to a special set in Redis, and remove it when the jobs is finished.

On top of that, we add a special method that is executed at Sidekiq's start-up, and will fetch the jobs that didn't finished,
ie. which information are still in Redis.

 Finally, to prevent that a job being performed is queued another time during a Sidekiq process boot
 (in case of multiple workers for the same webapp for example), a timeout is set to check again if the job's information
 is still in Redis after its duration.


## Usage

### Basic usage

The easiest way to use `SidekiqReliableRequeue` is simply to add in your sidekiq initializer

```ruby
SidekiqReliableRequeue.initialize(options)
```

`SidekiqReliableRequeue` enables two new options that can be passed to Sidekiq workers or delayed method,
just like any other options (`retry`, `queue`, etc.).

These two options are `reliable_requeue` and `requeue_timeout`.
* `reliable_requeue (default: false)`: if set to true, the job will use the reliable requeuing feature.
* `requeue_timeout (default: 20)`: timeout to check again after a Sidekiq process boot if the job is still not finished, thus supposed dead and requeued.

### Default configuration

These two options can be passed to to `SidekiqReliableRequeue/initialize`, and will be used by default for all workers or delayed methods.