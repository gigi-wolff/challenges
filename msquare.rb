require 'pry'

class Crypto
  attr_reader :uncoded_message, :message

  def initialize(uncoded_message)
    @uncoded_message = uncoded_message
    @message = normalize_plaintext
  end

  def normalize_plaintext # keep only letters and numbers from message   
    @uncoded_message.downcase.delete("^a-z0-9")
  end


  def size # size is number of cols in square
    cols = []
    cols = Math.sqrt(@message.length).divmod(1)
    cols[1] == 0 ? cols[0] : cols[0]+1 
  end


  # extract segment_size chunks from @message and return them in "square" array
  def plaintext_segments 
    segment_size = size
    (0...@message.length).step(segment_size).each_with_object([]) do |index, square|
      square << @message.slice(index,segment_size)
    end
  end

  def ciphertext
    cipher = ""
    index = 0
    last = size
    segments = plaintext_segments
    while index < last do
      segments.each { |segment| cipher << segment[index] unless segment[index].nil?}
      index += 1
    end
    cipher
  end

end

