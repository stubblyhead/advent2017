class Generator
  attr_reader :lsb, :value

  def initialize(seed, factor, multiple)
    @value = seed
    @factor = factor
    @multiple = multiple
  end

  def next_value
    @value = (@value * @factor) % 2147483647
    @lsb = @value.to_s(2)[-16..-1]
    next_value unless @value % @multiple == 0
  end
end

gen_a = Generator.new(634,16807,1)
gen_b = Generator.new(301,48271,1)

matchcount = 0
(1..40000000).each do |i|
  gen_a.next_value
  gen_b.next_value
  matchcount += 1 if gen_a.lsb == gen_b.lsb
  puts "cycle #{i}" if i % 1000000 == 0
end

puts "#{matchcount} matches after 40,000,000 cycles for part 1"

gen_a = Generator.new(634,16807,4)
gen_b = Generator.new(301,48271,8)

matchcount = 0
(1..5000000).each do |i|
  gen_a.next_value
  gen_b.next_value
  matchcount += 1 if gen_a.lsb == gen_b.lsb
  puts "cycle #{i}" if i % 500000 == 0
end

puts "#{matchcount} matches after 5,000,000 cycles for part 2"
