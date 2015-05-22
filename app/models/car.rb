class Car < ActiveRecord::Base
  validates :model,
    presence: {},
    allow_blank: false
  validates :make,
    presence: {},
    allow_blank: false
  validates :year,
    presence: {},
    numericality: { only_integer: true }

  has_many :mileages
  has_many :tasks
end
