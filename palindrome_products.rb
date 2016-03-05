module MinAndMax
  attr_accessor :value, :factors_

  def initialize
    @value = 0
    @factors_ = []
  end

  def factors
    factors_
  end
end

class Largest
  include MinAndMax
end

class Smallest
  include MinAndMax
end

class Palindromes
  attr_reader :max_factor, :min_factor, :palindromes_factors

  def initialize(min_max_factors)
    @max_factor = min_max_factors[:max_factor]
    @min_factor = min_max_factors[:min_factor] ? min_max_factors[:min_factor] : 1
    @palindromes_factors = {}
  end

  def palindrome?(num)
    num.to_s == num.to_s.reverse
  end

  def generate
    i = min_factor
    while i <= max_factor
      j = i
      while j <= max_factor
        # palindrome_factors is {[factors]=>product}
        product = i * j
        palindromes_factors[[i, j]] = product if palindrome?(product)
        j += 1
      end
      i += 1
    end
  end

  def smallest
    smallest = Smallest.new
    smallest.value = palindromes_factors.values.min
    smallest.factors_ = palindromes_factors.select { |_k, v| v == smallest.value }.keys
    smallest
  end

  def largest
    largest = Largest.new
    largest.value = palindromes_factors.values.max
    largest.factors_ = palindromes_factors.select { |_k, v| v == largest.value }.keys
    largest
  end
end
