# Bonfig
[![Build Status](https://travis-ci.org/GeorgeErickson/bonfig.png?branch=master)](https://travis-ci.org/GeorgeErickson/bonfig)
[![Code Climate](https://codeclimate.com/github/GeorgeErickson/bonfig.png)](https://codeclimate.com/github/GeorgeErickson/bonfig)
[![Coverage Status](https://coveralls.io/repos/GeorgeErickson/bonfig/badge.png?branch=master)](https://coveralls.io/r/GeorgeErickson/bonfig?branch=master)
[![Dependency Status](https://gemnasium.com/GeorgeErickson/bonfig.png)](https://gemnasium.com/GeorgeErickson/bonfig)
[![Gem Version](https://badge.fury.io/rb/bonfig.png)](http://badge.fury.io/rb/bonfig)

Simple configuration for modules.

## Install
```ruby
gem 'bonfig'
```

## Usage
```ruby
module MyModule
  extend Bonfig

  bonfig do
    config :index_name, default: 'test'
    config :redis do
      config :port, default: 6379
      config :host, default: 'localhost'
      config :db, default: 1
    end
  end
end


MyModule.config do |c|
  c.index_name = 'dev'

  c.redis = {port: 1234, host: '0.0.0.0' }
  # Or
  c.redis do |r|
    r.port = 1234
    r.host = '0.0.0.0'
  end
  # Or
  c.redis.port = 1234
  c.redis.host = '0.0.0.0'
end


puts MyModule.config.index_name # 'dev'
puts MyModule.config.redis.port  # 1234
puts MyModule.config.redis.host  # '0.0.0.0'
puts MyModule.config.redis.db  # 1
```
