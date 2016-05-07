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

  def size # size is number of columns in matrix
    cols = []
    cols = Math.sqrt(@message.length).divmod(1)
    cols[1] == 0 ? cols[0] : cols[0]+1 
  end

  # extract segment_size chunks from @message and return them in segment_array
  def plaintext_segments 
    segment_size = size
    (0...@message.length).step(segment_size).each_with_object([]) do |index, segment_array|
      segment_array << @message.slice(index,segment_size)
    end
  end

  def ciphertext
    cipher = ""
    segments = plaintext_segments
    (0..size).each do |col| # loop through each column, storing results in "cipher"
      segments.each { |segment| cipher << segment[col] unless segment[col].nil?}
    end
    cipher
  end


  def normalize_ciphertext
    segments = plaintext_segments
    vertical_segment = ""

    (0..size).each do |col| # loop through each column, storing results in vertical_segment
      segments.each do |segment| # store the letter in column "col" into vertical_segment
        vertical_segment << segment[col] unless segment[col].nil?
      end
      vertical_segment << " "
    end
    vertical_segment.rstrip!
  end

  private

  def number_of_rows
    rows = []
    rows = (@message.length).divmod(size)
    rows[1] == 0 ? rows[0] : rows[0]+1 
  end

end
