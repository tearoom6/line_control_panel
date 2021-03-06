require 'line/bot'

module LineApi
  extend ActiveSupport::Concern

  included do
  end

  class_methods do
  end

  def line_bot_client
    @line_bot_client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end
  end

end
