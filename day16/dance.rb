class Dance
  attr_reader :dancers

  def initialize(dancers)
    @dancers = dancers
  end

  def spin(num)
    @dancers = @dancers.drop(@dancers.length - num) + @dancers.take(@dancers.length - num)
  end

  def exchange(a, b)
    temp = @dancers[a]
    @dancers[a] = @dancers[b]
    @dancers[b] = temp
  end

  def partner(a,b)
    idx_a = @dancers.index(a)
    idx_b = @dancers.index(b)
    exchange(idx_a, idx_b)
  end

end

dance = Dance.new(%w[a b c d e])

dance.spin(1)
dance.exchange(3,4)
dance.partner('e','b')

print dance.dancers
