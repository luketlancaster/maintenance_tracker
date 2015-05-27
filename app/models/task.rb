class Task < ActiveRecord::Base
  validates :name,
    presence: {},
    allow_blank: false
  validates :mileage,
    presence: {},
    numericality: { only_intenger: true, greater_than: 0 }

  has_one :car
end
