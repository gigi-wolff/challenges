class PhoneNumber
  BAD_NUMBER = "0000000000".freeze

  def initialize(num)
    @number = num
  end

  def number
    cleanup_number
    valid_number? ? @number : BAD_NUMBER
  end

  def area_code
    @number.slice(0..2)
  end

  def to_s
    number
    "(" + area_code + ") " + @number.slice(3..5) + "-" + @number.slice(6..9)
  end

  private

  def valid_number?
    return false if @number.length < 10 || @number.length >= 11
    true
  end

  def cleanup_number
    return BAD_NUMBER unless /[[:alpha:]]/.match(@number).nil?
    @number = @number.each_char.select { |c| /[0123456789]/.match(c) }.join
    @number = @number.slice!(1..10) if @number.length == 11 && @number.start_with?("1")
  end
end
