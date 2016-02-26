# Gigi Wolff
# Clock challenge
# https://github.com/gigi-wolff/challenges/blob/master/clock.rb

class Clock
  attr_accessor :hr, :min

  def initialize(hr_, min_)
    @hr = hr_
    @min = min_
  end

  def self.at(hr_=0, min_=0)
    Clock.new(hr_, min_)
  end

  def change_time(delta_minutes)
    total_mins = (hr * 60) + min + delta_minutes
    hours_and_mins = total_mins.divmod(60)
    @min = hours_and_mins[1]
    if hours_and_mins[0] <= 0 
      @hr = 24 + hours_and_mins[0] 
    elsif hours_and_mins[0] >= 24
      @hr = hours_and_mins[0].modulo(24)
    else
      @hr = hours_and_mins[0]
    end
  end

  def +(add_mins)
    change_time(add_mins)
    self
  end

  def -(substract_mins)
    change_time(-substract_mins)
    self
  end

  def ==(other)
    hr == other.hr && min == other.min
  end

  def to_s
    minutes = min < 10 ? "0" + min.to_s : min.to_s
    hours = hr < 10 ? "0" + hr.to_s : hr.to_s
    hours + ":" + minutes
  end
end
