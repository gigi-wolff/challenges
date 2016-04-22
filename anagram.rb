class Anagram
  def initialize(word)
    @word = word # target word
  end

  def match(word_array)
    # find all possible words that are the same size as the target
    possible_matches = word_array.select { |word| word.size == @word.size && word.casecmp(@word) != 0 }

    # sort characters in each word and compare to target
    possible_matches.select { |word| word.downcase.chars.sort == @word.downcase.chars.sort }
  end
end
