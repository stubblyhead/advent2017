class Buffer
  attr_reader :start, :stepsize, :buffer

  def initialize(stepsize)
    @stepsize = stepsize
    @buffer = Array.new(1,0)
    @start = 0
  end

  def cycle
    next_value = @buffer.length
    next_position = (@start + @stepsize) % @buffer.length + 1
    @buffer = @buffer.insert(next_position, next_value)
    @start = @buffer.index(next_value)
  end
end

spinlock = Buffer.new(316)
(1..2017).each do |i|
  spinlock.cycle
  #puts spinlock.buffer[1]
end

puts spinlock.buffer[spinlock.start + 1]

(2018..50000000).each do |i|
  spinlock.cycle
end

position_zero = spinlock.buffer.index(0)
puts spinlock.buffer[position_zero + 1]
