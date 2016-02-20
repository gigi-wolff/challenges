require "pry"

class PhoneNumber
  BAD_NUMBER = "0000000000".freeze

  def initialize(num)
    @phone_number = num
  end

  def number
    phone_number
  end

  def area_code
    phone_number.slice(0..2)
  end

  def to_s
    "(" + area_code + ") " + phone_number.slice(3..5) + "-" + phone_number.slice(6..9)
  end

  private

  def phone_number # read accessor cleans up number
    return BAD_NUMBER unless /[[:alpha:]]/.match(@phone_number).nil?
    @phone_number = @phone_number.each_char.select { |c| /[0123456789]/.match(c) }.join
    @phone_number.slice!(0) if @phone_number.length == 11 && @phone_number.start_with?("1")
    @phone_number.length == 10 ? @phone_number : BAD_NUMBER
  end
end
