class Dance
  attr_reader :dancers

  def initialize(dancers)
    @dancers = dancers
  end

  def spin(num)
    length = @dancers.length
    @dancers = @dancers.drop(length - num) + @dancers.take(length - num)
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
permutations = [dance.dancers.clone]
match = false

until match
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
  puts "first iteration: #{dance.dancers.join}" if permutations.length == 1

  if permutations.index(dance.dancers)
    match = true
  else
    permutations.push(dance.dancers.clone)
  end
end

puts "one billionth iteration: #{permutations[1000000000 % permutations.length].join}"
