class KnotHash < Array

  attr_reader :current, :skip, :hash

  def initialize(lengths)
    super(255)
    @current = @skip = 0
    (0..255).each { |i| self[i] = i }
    self.calculate_hash(lengths)
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

  def split_array
    splitary=[]
    tempary = self.clone
    while tempary != []
      splitary.push(tempary.take(16))
      tempary = tempary.drop(16)
    end
    splitary
  end

  def calculate_hash(lengths)
    lengths += [17, 31, 73, 47, 23]
    (1..64).each do |iter|
      lengths.each do |i|
        self.twist(i.to_i)
      end
    end
    dense = []
    splitary = split_array

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
    @hash = knothash
  end
end


keystring = 'flqrgnkx'
disk = []
(0..127).each do |i|
  lengths = []
  thiskey = "#{keystring}-#{i}"
  thiskey.each_byte { |i| lengths.push(i) }
  disk.push(KnotHash.new(lengths))
end

grid = []
count = 0

disk.each_index do |i|
  line = "%0#{disk[i].hash.size*4}b" % disk[i].hash.hex.to_i
  grid.push([])
  (0..127).each do |j|
    grid[i].push(Array.new(2,0))
    grid[i][j][0] = line[j].to_i
  end
  count += line.count('1')
end


p grid
puts "#{count} used squares"
