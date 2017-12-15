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

gen_a = Generator.new(65,16807,4)
gen_b = Generator.new(8921,48271,8)

matchcount = 0
(1..5).each do |i|
  gen_a.next_value
  gen_b.next_value
  #matchcount += 1 if gen_a.lsb == gen_b.lsb
  print "#{gen_a.lsb}\n#{gen_b.lsb}\n\n"
end

#puts matchcount
