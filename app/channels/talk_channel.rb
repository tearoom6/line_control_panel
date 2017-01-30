class TalkChannel < ApplicationCable::Channel
  include LineApi

  def subscribed
    stream_from 'talk_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    return if data['receiver_id'].blank? || data['message'].blank?
    response = line_bot_client.push_message(data['receiver_id'], data['message'])
    unless response.is_a? Net::HTTPSuccess
      logger.error "Failed to send message. receiver_id: #{data['receiver_id']} message: #{data['message']}"
      return
    end
    logger.info "Send message. receiver_id: #{data['receiver_id']} message: #{data['message']}"
    talk = Talk.find_by(receiver_id: data['receiver_id'])
    logger.warn 'Failed to find talk.' and return if talk.blank?
    message = Message.create(
      message_type: Message.message_types[data['message']['type']],
      talk_id: talk.id,
      content: data['message'].to_json,
    )
    logger.warn 'Failed to create message.' if message.blank?
  end
end
