# frozen_string_literal: true

module Dingtalk
  module Client
    # Basic exception
    class Error < StandardError; end

    # :nodoc:
    class ConfigurationError < Error
      attr_reader :key, :value, :valid_values

      def initialize(key, value, valid_values)
        @key          = key
        @valud        = value
        @valid_values = valid_values
        valid_values_str = Array(valid_values).join(', ')
        message = if value.blank?
                    "#{key} not configured or configured with blank value, valid_values: #{valid_values_str}"
                  else
                    "Configure #{key} with value #{value} failed, valid_values: #{valid_values_str}"
                  end
        super(message)
      end
    end
  end
end
