# frozen_string_literal: true

module Dingtalk
  module Client
    module GroupRobotClient
      # @see https://open-doc.dingtalk.com/microapp/serverapi2/qf2nxq#a-nameytovydamarkdown%E7%B1%BB%E5%9E%8B
      module NotifyText
        # @param code    [Symbol] set token_code and template_file
        # @param content [String]
        # @option options [String]  template_file (code)  without file suffix
        # @option options [Boolean] is_at_all     (false)
        # @option options [Array]   at_mobiles    ([])
        def notify_text(code, content, **options)
          options.with_defaults!(
            is_at_all: false,
            at_mobiles: []
          )
          token_code = code.to_sym
          token = fetch_token(token_code)
          content = String(content)
          is_at_all = is_at_all != false
          at_mobiles = Array(at_mobiles)
          body = get_text_body(content, is_at_all, at_mobiles)
          notify(token, body)
        end

        private

        # @param content    [String]
        # @param is_at_all  [Boolean]
        # @param at_mobiles [Array]
        # @return [Hash]
        def get_text_body(content, is_at_all, at_mobiles)
          {
            msgtype: 'text',
            text: {
              content: content
            },
            at: {
              atMobiles: at_mobiles,
              isAtAll: is_at_all
            }
          }
        end
      end
    end
  end
end
