class Buffer
  attr_reader :start, :stepsize, :buffersize, :spot_one

  def initialize(stepsize)
    @stepsize = stepsize
    @start = 0
    @buffersize = 1
    @spot_one = nil
  end

  def cycle
    @buffersize += 1
    @start = (@start + @stepsize) % @buffersize + 2
    @spot_one = @buffersize if @start == 1
  end
end

spinlock = Buffer.new(316)
(1..2017).each do |i|
  spinlock.cycle
  #puts spinlock.buffer[1]
end

puts spinlock.spot_one
#(2018..50000000).each do |i|
#  spinlock.cycle
#end
