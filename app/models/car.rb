class Car
  attr_accessor :model, :year

  def self.all
    Database.execute("SELECT model, year FROM cars").map do |row|
      car = Car.new
      car.model = row[0]
      car.year = row[1]
      car
    end
  end

  def self.count
    Database.execute("SELECT COUNT(id) FROM cars")[0][0]
  end

  def self.create(year, make, model)
    if make.empty? or model.empty? or year.zero?
      raise ArgumentError.new("empty string")
    else
      Database.execute("INSERT INTO cars (year, make, model) VALUES (?,?,?)", year, make, model)
    end
  end
end
