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

gen_a = Generator.new(65,16807)
gen_b = Generator.new(8921,48271)

(1..5).each do |i|
  gen_a.next_value
  gen_b.next_value
  print "#{gen_a.lsb}\n#{gen_b.lsb}\n\n"
end
