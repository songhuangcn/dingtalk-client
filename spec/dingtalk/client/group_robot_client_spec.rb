# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Dingtalk::Client::GroupRobotClient do
  include Dingtalk::Client::GroupRobotClient

  context 'NotifyFeedcard' do
    it 'raise error if links invalid' do
      link = { a: 1 }
      expect {
        notify_feedcard(:test, link)
      }.to raise_error(ArgumentError)
    end
    it 'notify success' do
      body = '{"errmsg":"ok","errcode":0}'
      response = double(parsed_response: JSON.parse(body),
                        code: 200,
                        message: 'OK',
                        body: body)
      allow(subject).to receive(:post).and_return(response)
      link = { title: 'title', messageURL: 'message_url', picURL: 'pic_url' }
      result = notify_feedcard(:test, link)
      expect(result).to be_success
    end
  end
  context 'NotifyText' do
    it 'notify success' do
      body = '{"errmsg":"ok","errcode":0}'
      response = double(parsed_response: JSON.parse(body),
                        code: 200,
                        message: 'OK',
                        body: body)
      allow(subject).to receive(:post).and_return(response)
      result = notify_text(:test, 'message')
      expect(result).to be_success
    end
  end
  context 'NotifyMarkdown' do
    it 'raise error if token code not found' do
      expect {
        notify_markdown(:not_exist, 'message_title', template_file: 'test')
      }.to raise_error(ArgumentError)
    end
    it 'raise error if template_file not found' do
      expect {
        notify_markdown(:test, 'message_title', template_file: 'NOT_EXIST')
      }.to raise_error(ArgumentError)
    end
    it 'failed if got HTTP Error' do
      exception = HTTParty::Error.new('异常错误')
      allow(subject).to receive(:post).and_raise(exception)
      result = notify_markdown(:test, 'message_title')
      expect(result).to be_failed
      expect(result.message).to eq(exception.inspect)
    end
    it 'failed if title blank' do
      body = '{"errmsg":"message param title is null ","errcode":300001}'
      response = double(parsed_response: JSON.parse(body),
                        code: 200,
                        message: 'OK',
                        body: body)
      allow(subject).to receive(:post).and_return(response)
      result = notify_markdown(:test, '')
      expect(result).to be_failed
    end
    it 'failed if token not exist' do
      body = '{"errmsg":"token is not exist","errcode":300001}'
      response = double(parsed_response: JSON.parse(body),
                        code: 200,
                        message: 'OK',
                        body: body)
      allow(subject).to receive(:post).and_return(response)
      result = notify_markdown(:invalid_token, 'message_title', template_file: 'test')
      expect(result).to be_failed
    end
    it 'notify success' do
      @title = 'test_title'
      @body  = 'test_body'
      body = '{"errmsg":"ok","errcode":0}'
      response = double(parsed_response: JSON.parse(body),
                        code: 200,
                        message: 'OK',
                        body: body)
      allow(subject).to receive(:post).and_return(response)
      result = notify_markdown(:test, 'message_title')
      expect(result).to be_success
    end
  end
end
