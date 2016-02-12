require "pry"

class Luhn
  def initialize(number=0)
    @number = []
    number.to_s.each_char { |c| @number << c.to_i }
  end
 
  def addends
    arr = @number.reverse!
    arr.map!.with_index do |x, i|
      if i.even? 
        x
      else
       (2 * x > 10 ? 2 * x - 9 : 2 * x)
      end
   end.reverse!
  end

  def checksum
    addends.reduce(:+)
  end

  def valid?
    checksum.modulo(10) == 0
  end

  def create(number=0)
    number = number * 10
    @number = []
    number.to_s.each_char { |c| @number << c.to_i }
    addends
  end
end

=begin
num = 738
luhn = Luhn.new(num)
p "create: #{luhn.create(873_956)}"
puts "is valid? #{luhn.valid?}"
=end