class Task
  attr_accessor :id, :car_id, :name, :mileage, :completed

  def self.all
    Database.execute("SELECT car_id, name, milage, completed FROM tasks").map do |row|
    task = Task.new
  end
  end
end
