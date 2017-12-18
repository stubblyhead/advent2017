class Buffer
  attr_reader :start, :stepsize, :buffersize, :spot_one

  def initialize(stepsize)
    @stepsize = stepsize
    @start = 0
    @buffersize = 1
    @spot_one = nil
  end

  def cycle
    @start = (@start + @stepsize) % @buffersize + 2
    @spot_one = @buffersize if @start == 1
  end
end

spinlock = Buffer.new(316)
(1..2017).each do |i|
  spinlock.cycle
end

index_one_value = 1
next_index = 1
(2..50_000_000).each do |i|
  next_index = (next_index + 316) % i + 1
  index_one_value = i if next_index == 1
end

puts index_one_value
