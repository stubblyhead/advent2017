class Generator
  attr_reader :lsb, :value

  def initialize(seed, factor)
    @value = seed
    @factor = factor
  end

  def next_value
    @value = (@value * @factor) % 2147483647
    @lsb = @value.to_s(2)[-16..-1]
  end
end

gen_a = Generator.new(634,16807)
gen_b = Generator.new(301,48271)

matchcount = 0
(1..40000000).each do |i|
  gen_a.next_value
  gen_b.next_value
  matchcount += 1 if gen_a.lsb == gen_b.lsb
end

puts matchcount
