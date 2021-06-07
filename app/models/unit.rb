class Unit < ApplicationRecord
  has_many :measurements

  validates :title, presence: true
end
