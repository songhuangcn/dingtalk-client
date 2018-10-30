# frozen_string_literal: true

require 'httparty'
require 'active_support/all'
require 'dingtalk/client/errors'
require 'dingtalk/client/result'
require 'dingtalk/client/configurable'

module Dingtalk
  # DingTalk Client
  # @see https://open-doc.dingtalk.com/
  module Client
    extend ActiveSupport::Autoload
    autoload :GroupRobotClient
    include Configurable

    def self.included(base)
      base.include GroupRobotClient
    end
  end
end
