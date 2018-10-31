# frozen_string_literal: true

module Dingtalk
  module Client
    module GroupRobotClient
      # @see https://open-doc.dingtalk.com/microapp/serverapi2/qf2nxq#a-nameytovydamarkdown%E7%B1%BB%E5%9E%8B
      module NotifyMarkdown
        # @param code  [Symbol] set token_code and template_file
        # @param title [String]
        # @option options [String]  template_file (code)  without file suffix
        # @option options [Boolean] is_at_all     (false)
        # @option options [Array]   at_mobiles    ([])
        # @yield a block which will execute in template locale environment
        def notify_markdown(code, title, **options, &block)
          options.with_defaults!(
            template_file: code,
            is_at_all: false,
            at_mobiles: []
          )
          token_code = code.to_sym
          token = fetch_token(token_code)
          title = String(title)
          template_file = String(options[:template_file])
          is_at_all = is_at_all != false
          at_mobiles = Array(at_mobiles)
          content = get_markdown_content(template_file, &block)
          body = get_markdown_body(title, content, is_at_all, at_mobiles)
          notify(token, body)
        end

        private

        # @param template_file [String]
        # @yield a block which will execute in template locale environment
        def get_markdown_content(template_file, &block)
          instance_eval(&block) if block
          path = "#{Dingtalk::Client.config.template_dir}/#{template_file}.markdown.erb"
          ERB.new(File.read(path)).result(binding)
        rescue Errno::ENOENT
          raise ArgumentError, "Not found template: #{File.expand_path(path)}"
        end

        # @param title      [String]
        # @param content    [String]
        # @param is_at_all  [Boolean]
        # @param at_mobiles [Array]
        # @return [Hash]
        def get_markdown_body(title, content, is_at_all, at_mobiles)
          {
            msgtype: 'markdown',
            markdown: {
              title: title,
              text: content
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
