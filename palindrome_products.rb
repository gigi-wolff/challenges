class Palindromes
  attr_reader :max_factor, :min_factor, :palindromes_factors

  Largest = Struct.new(:value, :factors)
  Smallest = Struct.new(:value, :factors)

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
    value = palindromes_factors.values.min
    factors = palindromes_factors.select { |_k, v| v == value }.keys
    Smallest.new(value, factors)
  end

  def largest
    value = palindromes_factors.values.max
    factors = palindromes_factors.select { |_k, v| v == value }.keys
    Largest.new(value, factors)
  end
end
