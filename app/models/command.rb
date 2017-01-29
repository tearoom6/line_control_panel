class Command < ApplicationRecord
  enum message_type: [:text, :image, :video, :audio, :location, :sticker]

  belongs_to :command_group
end
