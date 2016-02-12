require "pry"

class CircularBuffer
  BufferEmptyException = "Buffer is empty!"
  BufferFullException = "Buffer is full!"

  def initialize(size = 0, data = nil)
    @head = 0 # points to oldest item added
    @tail = 0 # points to where next item will be added
    @size = size
    @buffer = Array.new(size)
    write(data) unless data.nil?
  end

  def read
    fail BufferEmptyException if empty_buffer?
    data = @buffer[@head]
    free_up_location
    update_read_pointer
    data
  end

  def write(data)
    return @buffer if data.nil?
    fail BufferFullException if buffer_full?
    @buffer[@tail] = data
    update_write_pointer
  end

  def write!(data)
    return @buffer if data.nil?
    if buffer_full? # force write, replace oldest element
      @buffer[@head] = data
      update_read_pointer
    else
      @buffer[@tail] = data
      update_write_pointer
    end
  end

  def clear
    @buffer.map! { nil }
  end

  def to_s
    s = "["
    @buffer.each { |i| i.nil? ? s += "_ " : s += "#{i} " }
    s += "]"
  end

  private

  def empty_buffer?
    #@buffer.count(nil) == 0
    @buffer.select {|i| i != nil}.size == 0 ? true : false 
  end

  def update_write_pointer
    @tail = (@tail += 1).modulo(@size)
  end

  def update_read_pointer
    @head = (@head += 1).modulo(@size)
  end

  def free_up_location
    @buffer[@head] = nil
  end

  def buffer_full?
    @buffer.count(nil) == 0
  end
end