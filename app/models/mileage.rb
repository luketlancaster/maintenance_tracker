class Mileage < ActiveRecord::Base
  validates :mileage,
    presence: {},
    numericality: { only_integer: true, greater_than: 0 }

  has_one :car
end
