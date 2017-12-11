class CircularArray < Array

  attr_reader :current, :skip

  def initialize(array)
    super
    @current = @skip = 0
  end

  def pinch(start, length)
    i = slice(start % size, length)
    if i.size != length
      i += slice(0, length - i.size)
    end
    i
  end
end
