require 'mysql2'
require 'dotenv/load'

class Heroes
  def initialize
    @db = Mysql2::Client.new(
      host: ENV['DB_HOST'],
      username: ENV['DB_USERNAME'],
      password: ENV['DB_PASSWORD'],
      database: ENV['DB_NAME']
    )
  end

  def all
    @heroes = @db.query('SELECT title FROM heroes').to_a.map{ |hero| hero['title'] }
  end
end