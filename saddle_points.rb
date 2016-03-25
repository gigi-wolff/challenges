require 'pry'
require 'set'

class Matrix
  attr_reader :matrix

  def initialize(matrix_str)
    @matrix = to_matrix(matrix_str)
  end

  def saddle_points
    (Set.new(all_row_max) & Set.new(all_col_min)).to_a # intersection
  end

  def columns(c)
    @matrix.map { |row| row[c] }
  end

  def rows(r)
    @matrix[r]
  end

  private

  def to_matrix(matrix_str)
    rows = matrix_str.split("\n") # "1 2\n10 20"  ==> ["1 2", "10 20"]
    rows.map do |row|
      row.split(" ").map(&:to_i) # "1 2" ==> [1, 2]
    end
  end

  def all_row_max
    @matrix.each_with_index.with_object([]) do |(row, row_index), row_max_values|
      max = row.max
      row.each_with_index do |value, col_index|
        row_max_values << [row_index, col_index] if value == max
      end
    end
  end

  def all_col_min
    @matrix.each_with_index.with_object([]) do |(_, col_index), col_min_values|
      column = columns(col_index)
      min = column.min
      column.each_with_index do |value, row_index|
        col_min_values << [row_index, col_index] if value == min
      end
    end
  end
end
