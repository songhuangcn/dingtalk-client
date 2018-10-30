# frozen_string_literal: true

Dingtalk::Client.configure do |config|
  config.template_dir = "#{__dir__}/../files"
  config.group_robot_tokens = {
    test: 'TOKEN',
    invalid_token: 'INVALID_TOKEN'
  }
end
