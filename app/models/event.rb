class Event < ApplicationRecord
  enum event_type: [:message, :follow, :unfollow, :join, :leave, :postback, :beacon]
end
