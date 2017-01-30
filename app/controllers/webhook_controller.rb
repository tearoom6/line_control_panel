class WebhookController < ApplicationController
  include LineApi

  protect_from_forgery :except => [:on_message]

  def on_message
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless line_bot_client.validate_signature(body, signature)
      render nothing: true, status: 400 and return
    end

    events = line_bot_client.parse_events_from(body)
    events.each do |event|
      logger.info "Received event: #{event.to_json}"

      source = event['source']
      if source.blank? || ! source.is_a?(Hash)
        logger.warn 'Event source not found.'
        break
      end
      talk = Talk.find_or_create_by(
        talk_type: Talk.talk_types[source['type']],
        receiver_id: source.fetch("#{source['type']}Id"),
      )
      logger.warn 'Failed to create talk.' and break if talk.blank?

      event_record = Event.create(
        event_type: Event.event_types[event['type']],
        talk_id: talk.id,
        timestamp: event['timestamp'],
        content: event.to_json,
      )
      logger.warn 'Failed to create event.' and break if talk.blank?

      if event_record.message? && event.message.present?
        message = Message.create(
          message_type: Message.message_types[event.message['type']],
          talk_id: talk.id,
          event_id: event_record.id,
          content: event.message.to_json,
        )
        logger.warn 'Failed to create message.' and break if message.blank?
      end

      if event_record.follow? || event_record.join?
        logger.info "Activete talk: #{talk.id}" if talk.update(status: :active)
      end

      if event_record.unfollow? || event_record.leave?
        logger.info "Inactivete talk: #{talk.id}" if talk.update(status: :inactive)
      end
    end

    render nothing: true, status: 200
  end

end
