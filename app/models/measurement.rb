class Measurement < ApplicationRecord
  belongs_to :user
  belongs_to :unit

  scope :with_units, -> { includes(:unit) }

  def self.currentUsers(user)
    Measurement.all.where(user_id: user.id)
  end

  validates :value, presence: true
end
