require 'pry'

module Guts
  attr_accessor :value, :factors_of_value

  def initialize
    @value = 0
    @factors_of_value = []
  end

  def factors
    factors_of_value
  end

  def to_s
    value_str = value.to_s
    idx = value_str.size/2
    value_str.size > 4 ? value_str.insert(idx,'_') : value_str
  end
end

class Largest
  include Guts
end

class Smallest
  include Guts
end

class Palindromes

  attr_reader :max_factor, :min_factor, :palindrome_set

  def initialize(factor_hash)
    @max_factor = factor_hash[:max_factor]
    factor_hash[:min_factor] ? @min_factor = factor_hash[:min_factor] : @min_factor = 1
    @palindrome_set = []
  end

  def palindrome(num)
    num_str = num.to_s
    idx = 0
    palindrome = true
    while idx < num_str.size/2
      num_str[idx]==num_str[num_str.size-idx-1] ? idx += 1 : (return false)
    end
    return true
  end

  def generate
    i = min_factor
    while i <= max_factor
      j = i
      while j <= max_factor
        palindrome_set << [i,j] if palindrome(j*i) 
        j=j+1
      end
      i=i+1
    end
  end

  def factors
    puts "smallest: #{@smallest}"
    puts "largest : #{@largest}"
  end

  def smallest
    smallest = Smallest.new
    smallest.factors_of_value = palindrome_set.min
    smallest.value = smallest.factors_of_value[0] * smallest.factors_of_value[1]
    smallest
  end

  def largest
    largest = Largest.new
    largest.factors_of_value << palindrome_set.max
    largest.value = largest.factors_of_value[0][0] * largest.factors_of_value[0][1]
    largest
  end
end

    palindromes = Palindromes.new(max_factor: 999, min_factor: 100)
    palindromes.generate
    largest = palindromes.largest
    puts 906_609, largest.value
    p largest.factors
=begin
    palindromes = Palindromes.new(max_factor: 99, min_factor: 10)
    palindromes.generate
    largest = palindromes.largest
    puts largest.value
    p largest.factors
=end







