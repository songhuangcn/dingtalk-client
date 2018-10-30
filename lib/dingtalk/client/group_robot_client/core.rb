# frozen_string_literal: true

module Dingtalk
  module Client
    module GroupRobotClient
      # Group Bobot core functions
      module Core
        private

        # @param token_code [Symbol]
        def fetch_token(token_code)
          Dingtalk::Client.config.group_robot_tokens[token_code].tap do |token|
            raise ArgumentError, "Not found token code: #{token_code}" unless token
          end
        end

        # @param token [String]
        # @param body  [Hash]
        def notify(token, body)
          response = GroupRobotClient.post(token, body: body.to_json)
          if response.parsed_response.try(:[], 'errcode').try(:zero?)
            Result.new(true)
          else
            message = <<-MESSAGE.gsub(/^\s+/, '')
              HTTP Status:   #{response.code} #{response.message}
              Response Body: #{response.body}
            MESSAGE
            Result.new(false, message: message)
          end
        rescue StandardError => exception
          Result.new(false, message: exception.inspect)
        end
      end
    end
  end
end
