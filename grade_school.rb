require "pry"

class School
  def initialize
    @roster = {}
  end

  def to_h
    result = {}
    @roster.keys.sort.each { |key| result[key] = @roster[key].sort }
    result
  end

  def add(name, grade)
    return @roster[grade] = [name] if @roster[grade].nil?
    @roster[grade] << name
  end

  def grade(input_grade)
    @roster.fetch(input_grade, [])
  end

  def to_s
    s = ""
    @roster.each { |k, v| s += "#{k}: #{v} \n" }
    s
  end
end
=begin
s = School.new
s.add("Zizi",4)
s.add("Howdy",4)
s.add("Doody",5)
s.add("Cowboy",5)
s.add("Gigi",1)
s.add("Zarrison",2)
s.add("Larry",2)
s.add("Gillian",3)
puts s.to_h
=end