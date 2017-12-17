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

spinlock = Buffer.new(3)
(1..9).each do |i|
  spinlock.cycle
end

puts spinlock.buffer.join(' ')
