# frozen_string_literal: true

require 'dingtalk/client/group_robot_client/core'
require 'dingtalk/client/group_robot_client/notify_text'
require 'dingtalk/client/group_robot_client/notify_markdown'
require 'dingtalk/client/group_robot_client/notify_feedcard'

module Dingtalk
  module Client
    # @see https://open-doc.dingtalk.com/microapp/serverapi2/qf2nxq
    module GroupRobotClient
      include HTTParty
      include Core
      include NotifyText
      include NotifyMarkdown
      include NotifyFeedcard
      base_uri Dingtalk::Client.config.group_robot_webhook_prefix
      headers  'Content-Type' => 'application/json'
      logger   ::Logger.new($stdout), :debug, :curl if Dingtalk::Client.config.is_debugging
    end
  end
end
