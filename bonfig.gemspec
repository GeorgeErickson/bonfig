# -*- encoding: utf-8 -*-

require File.expand_path('../lib/bonfig/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "bonfig"
  gem.version       = Bonfig::VERSION
  gem.summary       = %q{A simple config mixin for gems.}
  gem.description   = %q{Configuration Mixin}
  gem.license       = "MIT"
  gem.authors       = ["George Erickson"]
  gem.email         = "george.erickson.jr@gmail.com"
  gem.homepage      = "https://github.com/GeorgeErickson/bonfig/"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.0'
  gem.add_development_dependency 'rake', '~> 0.8'
  gem.add_development_dependency 'rspec', '~> 2.4'
  gem.add_development_dependency 'coveralls', '~> 2.4'
end
