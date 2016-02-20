require "pry"

class PhoneNumber
  BAD_NUMBER = "0000000000".freeze
  
  def initialize(num)
    @phone_number = num
  end

  def number
    valid_number? ? phone_number : BAD_NUMBER
  end

  def area_code
    phone_number.slice(0..2)
  end

  def to_s
    "(" + area_code + ") " + phone_number.slice(3..5) + "-" + phone_number.slice(6..9)
  end

  private

  def valid_number?
    return false if phone_number.length < 10 || phone_number.length >= 11
    true
  end

  def phone_number #read accessor
    return BAD_NUMBER unless /[[:alpha:]]/.match(@phone_number).nil?
    clean_number = @phone_number.each_char.select { |c| /[0123456789]/.match(c) }.join
    clean_number.slice!(0) if clean_number.length == 11 && clean_number.start_with?("1")
    @phone_number = clean_number
  end

end

