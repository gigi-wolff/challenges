require 'pry'
require 'date'

class Meetup
  def initialize(month, year)
    @year = year
    @month = month
    @date = Date.new(@year, @month)
  end

  def day(weekday, schedule)
    day_of_week = { 0 => :sunday, 1 => :monday, 2 => :tuesday, 3 => :wednesday, 4 => :thursday, 5 => :friday, 6 => :saturday }
    weeks = { first: 7, second: 14, third: 21, fourth: 28, last: 35, teenth: 14 }

    offset_index = day_of_week.key(weekday) - Date.new(@year, @month, 1).wday # days between first day of month and first weekday
    day = offset_index + weeks.fetch(schedule) # number days from first of month to first, second, third or fourth weekday
    offset_index < 0 ? day += 1 : day -= 6
    day = edge_case(day, schedule) if schedule == :last || schedule == :teenth
    @date = Date.new(@year, @month, day)
  end

  private
  
  def edge_case(day, schedule)
    if schedule == :last
      day -= 7 if !Date.valid_date?(@year, @month, day) # overshot, go back a week
    elsif schedule == :teenth # move ahead or back a week if teenth is out of range
      day += 7 if day < 13
      day -= 7 if day > 19
    end
    day
  end
end
