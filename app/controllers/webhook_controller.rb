require 'line/bot'

class WebhookController < ApplicationController
  def on_message
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      render nothing: true, status: 400 and return
    end

    events = client.parse_events_from(body)
    events.each do |event|
      logger.info "Received event: #{event.to_json}"
    end

    render nothing: true, status: 200
  end

  private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
  end

end
