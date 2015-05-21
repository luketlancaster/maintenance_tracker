class Car
  attr_reader :id, :errors
  attr_accessor :model, :year, :make

  def initialize(make = nil)
    self.make = make
  end

  def self.all
    Database.execute("SELECT * FROM cars").map do |row|
      car = Car.new
      car.model = row['model']
      car.year = row['year']
      car.make = row['make']
      car.instance_variable_set(:@id, row['id'])
      car
    end
  end

  def self.count
    Database.execute("SELECT COUNT(id) FROM cars")[0][0]
  end

  def valid?
    if @model.strip.empty?
      @errors = "\"#{model}\" is not a valid model"
      false
    elsif @make.strip.empty?
      @errors = "\"#{make}\" is not a valid make"
      false
    elsif !year.class == Fixnum or @year.to_i.zero?
      @errors = "\"#{year}\" is not a valid year"
      false
    else
      @errors = nil
      true
    end
  end

  def save
    return false unless valid?
    if @id.nil?
      Database.execute("INSERT INTO cars (year, make, model) VALUES (?,?,?)", year, make, model)
      @id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
      true
    else
      Database.execute("UPDATE cars SET year = ?, make = ?, model = ? WHERE id = ?", year, make, model, id)
    end
  end

  def self.delete(car_id)
    if car_id.nil?
      "Car not found"
    else
      Database.execute("DELETE FROM cars WHERE id like #{car_id}")
    end
  end

end
