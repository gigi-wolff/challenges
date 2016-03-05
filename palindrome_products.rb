require 'pry'
require 'benchmark'
require 'minitest/autorun'

module MinAndMax
  attr_accessor :value, :factors_of_value

  def initialize
    @value = 0
    @factors_of_value = []
  end

  def factors
    factors_of_value
  end
end

class Largest
  include MinAndMax
end

class Smallest
  include MinAndMax
end

class Palindromes
  attr_reader :max_factor, :min_factor, :palindrome_hash

  def initialize(factor_hash)
    @max_factor = factor_hash[:max_factor]
    @min_factor = factor_hash[:min_factor] ? factor_hash[:min_factor] : 1
    @palindrome_hash = {}
  end

  def palindrome(num)
    num.to_s == num.to_s.reverse
  end

  def generate
    i = min_factor
    while i <= max_factor
      j = i
      while j <= max_factor
        product = i * j
        palindrome_hash[[i, j]] = i * j if palindrome(product)
        j += 1
      end
      i += 1
    end
  end

  def smallest
    smallest = Smallest.new
    smallest.value = palindrome_hash.values.min
    smallest.factors_of_value = palindrome_hash.select { |_k, v| v == smallest.value }.keys
    smallest
  end

  def largest
    largest = Largest.new
    largest.value = palindrome_hash.values.max
    largest.factors_of_value = palindrome_hash.select { |_k, v| v == largest.value }.keys
    largest
  end
end
