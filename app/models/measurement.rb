class Measurement < ApplicationRecord
  belongs_to :user
  belongs_to :unit

  validates :value, presence: true
end
