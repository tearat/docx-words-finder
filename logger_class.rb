# Renders found heroes list
class Logger
  def initialize(matches = nil)
    @matches = {}
    @matches = matches if matches
  end

  def append(matches)
    matches.each do |id, match|
      @matches[id] = { count: 0 } unless @matches.key? id
      @matches[id][:count] += match[:count]
    end
  end

  def show
    puts "Words: #{@matches.size}".green if @matches.size > 1
    puts 'Not found'.red if @matches.empty?

    @matches = @matches.sort_by{ |_, match| -match[:count] } if @matches.size > 1

    col_2_len = 0
    @matches.each do |word, _|
      col_2_len = word.length if word.length > col_2_len
    end

    @matches.each do |word, match|
      puts "# #{word.to_s.ljust(3, ' ').ljust(col_2_len, ' ')} | #{match[:count]}"
    end
  end
end