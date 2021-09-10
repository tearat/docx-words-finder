require 'colorize'

require './document_class'
require './logger_class'
require './heroes_class'

files = Dir.glob('files/*').select { |e| File.file? e }

# provide words with database
# heroes_model = Heroes.new
# heroes = heroes_model.all.map{ |hero| hero.split(' ')[0] }

# provide manually
heroes = ['Hero1', 'Hero2']

total_log = Logger.new if files.size > 1
files.each do |file|
  document = Document.new file
  matches = document.find heroes

  log = Logger.new matches
  log.show

  total_log.append matches if files.size > 1
end

if files.size > 1
  puts
  puts 'Total stats:'.green
  total_log.show
end
