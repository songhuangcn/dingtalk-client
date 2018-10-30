# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dingtalk/client/version'

Gem::Specification.new do |spec|
  spec.name          = 'dingtalk-client'
  spec.version       = Dingtalk::Client::VERSION
  spec.authors       = ['Pine Wong']
  spec.email         = ['pinewong@163.com']

  spec.summary       = 'A simple HTTP client wrapper for Dingtalk.'
  spec.description   = 'A simple HTTP client wrapper for Dingtalk.'
  spec.homepage      = 'https://github.com/pinewong/dingtalk-client'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.5'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_dependency 'activesupport', '~> 5.2.1'
  spec.add_dependency 'httparty',      '~> 0.16.2'
end
