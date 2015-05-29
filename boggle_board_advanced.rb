require "byebug"

class PossibleStrings
  attr_accessor :possible_strings

  def initialize(array)
    @array = array
    @possible_strings = []
  end

  def generate
    horizontal
    vertical
    diagonal
    reverse
    # Returns an array of strings
  end

  def horizontal
    @array.each do |row|
      @possible_strings << row.join(" ").gsub(/\s+/, "")
    end
  end

  def vertical
    @array.transpose.each do |col|
      @possible_strings << col.join(" ").gsub(/\s+/, "")
    end
  end

  def diagonal
    indexes = [[[0, 0], [1, 1], [2, 2], [3, 3]], [[1, 0], [2, 1], [3, 2]], [[0, 1], [1, 2], [2, 3]], [[0, 3], [1, 2], [2, 1], [3,0]], [[0, 2], [1, 1], [2, 0]], [[1, 3], [2, 2], [3, 1]]]
    temp_array = []
    indexes.each do |word|
      word.each do |row, col|
        temp_array << @array[row][col]
       end
     end
     @possible_strings << temp_array.shift(4).join(" ").gsub(/\s+/, "")
     @possible_strings << temp_array.shift(3).join(" ").gsub(/\s+/, "")
     @possible_strings << temp_array.shift(3).join(" ").gsub(/\s+/, "")
     @possible_strings << temp_array.shift(4).join(" ").gsub(/\s+/, "")
     @possible_strings << temp_array.shift(3).join(" ").gsub(/\s+/, "")
     @possible_strings << temp_array.shift(3).join(" ").gsub(/\s+/, "")
  end

  def right_diagonal
  end

  def reverse
    temp_strings = []
    @possible_strings.each do |string|
      temp_strings << string.reverse
    end
    @possible_strings += temp_strings
  end
end

class BoggleBoard
  def initialize
    @board = Array.new(4){Array.new(4)}
  end

  def shake!
    dices = Dices.read
    dices.each do |die|
      dices = Array.new(6){die.split(//)}
    end
    @board.each_with_index do |row, row_index|
      row.each_with_index do |col, col_index|
        @board[row_index][col_index] = ljust(replace_q(dices.sample.sample))
      end
    end
    to_s(@board)
  end

  def includes_word?(word)
    word = word.upcase!
    strings_list = PossibleStrings.new(@board)
    strings = strings_list.generate
    p strings
    strings.include?(word)
  end

  def replace_q(char)
    if char == "Q"
      "Qu"
    else
      char
    end
  end

  def ljust(element)
    element.ljust(3)
  end

  def to_s(array)
    array.each do |row|
      puts row.join(" ")
    end
  end
end

class Dices
  def self.read
    @dices = []
    File.foreach("dices.txt") do |line|
      line.gsub!("\n", "")
      @dices << line
    end
    @dices
  end
end


board = BoggleBoard.new
board.shake!
p board.includes_word?("irrl")
