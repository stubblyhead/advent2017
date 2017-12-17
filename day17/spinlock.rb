class Buffer < Array
  attr_reader :start, :stepsize

  def initialize(stepsize)
    @stepsize = stepsize
    @self[0] = 0
    @start = 0
  end

  def cycle
    next_value = @self.length
    next_position = (@start + @stepsize) % @self.length + 1
    @self = @self.insert(next_position, next_value)
    @start = @self.index(next_value)
  end

  
