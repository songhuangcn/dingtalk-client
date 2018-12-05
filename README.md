# Dingtalk Client

A simple HTTP client wrapper for [Dingtalk](https://open-doc.dingtalk.com/)

[![Gem Version](https://badge.fury.io/rb/dingtalk-client.svg)](https://rubygems.org/gems/dingtalk-client)
[![Build Status](https://travis-ci.org/pinewong/dingtalk-client.svg)](https://travis-ci.org/pinewong/dingtalk-client)
[![Test Coverage](https://codecov.io/github/pinewong/dingtalk-client/coverage.svg?branch=master)](https://codecov.io/github/pinewong/dingtalk-client?branch=master)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dingtalk-client'
```

And then execute:


```shell
$ bundle
```

Or install it yourself as:

```shell
$ gem install dingtalk-client
```

## Usage

### Group Robot Message

```ruby
# Config api token and message template directory
Dingtalk::Client.configure do |config|
  config.template_dir = '.'
  config.group_robot_tokens = { order: 'TOKEN' }
end
system %q(echo '> <%= @message %>' > order.markdown.erb)

# Notify markdown type message
Dingtalk::Client.notify_markdown(:order, 'Title') { @message = 'Awesome message' }

# Notify feedcard type
links = [{ title: 'title1', messageURL: '...', picURL: '...' }, { title: 'title2', messageURL: '...', picURL: '...' }]
Dingtalk::Client.notify_feedcard(:code, links)

# Notify text type
Dingtalk::Client.notify_text(:code, 'message')

# Want use instance in exist class?
class OrderController < ApplicationContrller
  include Dingtalk::Client
  
  def index
    @message = 'Some message'
    notify_markdown(:order, 'Title')
  end
end
```

## Help and Docs

* [RDoc](https://www.rubydoc.info/github/pinewong/dingtalk-client)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pinewong/dingtalk-client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Dingtalk::Client project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/pinewong/dingtalk-client/blob/master/CODE_OF_CONDUCT.md).
