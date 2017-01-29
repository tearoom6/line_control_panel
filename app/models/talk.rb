class Talk < ApplicationRecord
  enum talk_type: [:user, :group, :room]
  enum status: [:active, :inactive]
end
