class Message < ApplicationRecord
  enum message_type: [:text, :image, :video, :audio, :location, :sticker]
end
