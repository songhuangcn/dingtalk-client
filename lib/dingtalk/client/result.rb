# frozen_string_literal: true

module Dingtalk
  module Client
    # HTTP Response result
    class Result
      attr_reader :status, :message

      # @param status  [Boolean]
      # @param message [String]  ('')
      def initialize(status, message: '')
        @status  = status != false
        @message = message.to_s
      end

      def failed?
        !success?
      end

      def success?
        status
      end
    end
  end
end
