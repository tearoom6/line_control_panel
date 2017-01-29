class Talk < ApplicationRecord
  enum talk_type: [:user, :group, :room], _suffix: :talk
  enum status: [:active, :inactive]

  after_initialize :init_status

  def init_status
    self.active!
  end
end
