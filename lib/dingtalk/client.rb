# frozen_string_literal: true

require 'httparty'
require 'active_support/all'
require 'dingtalk/client/errors'
require 'dingtalk/client/result'

module Dingtalk
  # DingTalk Client
  # @see https://open-doc.dingtalk.com/
  module Client
    extend ActiveSupport::Autoload
    autoload :Configurable
    autoload :GroupRobotClient
    include Configurable
    include GroupRobotClient
  end
end
