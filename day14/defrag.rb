class KnotHash < Array

  attr_reader :current, :skip, :hash

  def initialize
    super(255)
    @current = @skip = 0
    (0..255).each { |i| self[i] = i }
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

lengths = []
File.open('./input') do |file|
  file.readline.chomp.each_byte { |i| lengths.push(i) }
end


ary = KnotHash.new()

#(0..255).each { |i| ary[i] = i}

ary.calculate_hash(lengths)
puts ary.hash
