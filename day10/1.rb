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

  def twist(length)
    subary = pinch(@current, length)
    subary.reverse!
    subary.each do |i|
      self[@current % size] = i
      @current += 1
    end
    @current += @skip
    @skip += 1
    @current %= size
  end
end

lengths = []
File.open('./input') do |file|
  lengths = file.readline.chomp.split(',')
end


ary = CircularArray.new([])

(0..255).each { |i| ary[i] = i}

lengths.each do |i|
  ary.twist(i.to_i)
end

puts ary[0] * ary[1]
