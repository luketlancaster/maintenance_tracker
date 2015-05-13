require 'sqlite3'

class Database

  def self.load_structure
    Database.execute <<-SQL
    CREATE TABLE IF NOT EXISTS cars (
      id integer PRIMARY KEY AUTOINCREMENT,
      make varchar(50) NOT NULL,
      model varchar(50) NOT NULL,
      year integer NOT NULL
    );
    SQL
    Database.execute <<-SQL
    CREATE TABLE IF NOT EXISTS tasks (
      id integer PRIMARY KEY AUTOINCREMENT,
      car_id integer,
      name varchar(20),
      milage integer,
      completed boolean not null default 0,
      FOREIGN KEY (car_id) REFERENCES cars (id)
    );
    SQL
  end

  def self.execute(*args)
    initialize_database unless defined?(@@db)
    @@db.execute(*args)
  end

  def self.initialize_database
    enviroment = ENV["TEST"] ? "test" : "production"
    database = "db/maintenance_tracker_#{enviroment}.sqlite"
    @@db = SQLite3::Database.new(database)
  end

end
