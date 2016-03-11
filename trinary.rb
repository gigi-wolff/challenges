class Trinary
  attr_reader :number
  BASE = 3

  def initialize(num)
    @number = num
  end

  def is_integer?
    /\D/.match(number).nil? 
  end

  def to_decimal
    return 0 unless is_integer? 
    number.reverse.each_char.with_index.map {|char, i| char.to_i*BASE**(i)}.reduce(:+)
  end
end
