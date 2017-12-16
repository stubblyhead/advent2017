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

moves = []
File.open('./input') do |file|
  moves = file.readline.split(',')
end

dance = Dance.new(('a'..'p').to_a)
moves.each do |i|
  case i[0]
  when 's'
    dance.spin(i[1..-1].to_i)
  when 'x'
    exch = i[1..-1].split('/')
    dance.exchange(exch[0].to_i, exch[1].to_i)
  when 'p'
    partners = i[1..-1].split('/')
    dance.partner(partners[0],partners[1])
  end
end

print "final positions: "
dance.dancers.each { |i| print i }
print "\n"
