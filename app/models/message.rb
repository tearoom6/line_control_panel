class Message < ApplicationRecord
  enum message_type: [:text, :image, :video, :audio, :location, :sticker]

  belongs_to :talk
  belongs_to :event, optional: true

  after_create_commit { MessageBroadcastJob.perform_later self }

  def content_hash
    JSON.parse(self.content) rescue {}
  end
end
