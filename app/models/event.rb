class Event < ApplicationRecord
  enum event_type: [:message, :follow, :unfollow, :join, :leave, :postback, :beacon]

  belongs_to :talk
  has_one :event
end
