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
  file.readline.chomp.each_byte { |i| lengths.push(i) }
end
lengths += [17, 31, 73, 47, 23]

ary = CircularArray.new([])

(0..255).each { |i| ary[i] = i}

(1..64).each do |iter|
  lengths.each do |i|
    ary.twist(i.to_i)
  end
end

dense = []

def split_array(ary)
  splitary=[]
  while ary != []
    splitary.push(ary.take(16))
    ary = ary.drop(16)
  end
  splitary
end

splitary = split_array(ary)


splitary.each do |i|
  xor = 0
  i.each { |j| xor ^= j }
  dense.push(xor)
end

knothash = ''
dense.each do |i|
  if i < 16
    knothash += ('0' + i.to_s(16))
  else
    knothash += i.to_s(16)
  end

end
print "\n"
puts knothash
