require 'docx'

class Document
  attr_reader :matches

  def initialize(filename)
    @filename = filename
  end

  def find(words)
    generate_capitals
    find_words_in_files words
  end

  def generate_capitals
    puts
    puts "> #{@filename}".green
    doc = Docx::Document.open(@filename)
    lines = []

    doc.paragraphs.each do |line|
      lines << line.to_s
    end

    capitals = []

    lines.each do |line|
      next unless line.strip

      words = line.split ' '
      words.each do |word|
        capitals << word if (word.length > 3) && (word[0] == word[0].upcase) && (word[0] =~ /[[:alpha:]]/)
      end
    end

    @capitals = capitals.join
  end

  def find_words_in_files(words)
    return unless @capitals

    matches = {}

    words.each do |word|
      scan = @capitals.scan(/#{word}[\s\.\,]/)
      matches[word] = { count: scan.size } if scan.any?
    end

    matches.sort_by{ |_, word| -word[:count] }
  end
end