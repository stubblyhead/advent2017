class Node
  attr_reader :pipes, :id

  def link(node)
    @pipes.push(node)
  end

  def initialize(id)
    @id = id
    @pipes = []
  end
end

networkmap = []
File.open('./input') do |file|
  file.each_line do |line|
    networkmap.push(line.chomp)
  end
end

network = []
networkmap.each do |node|
  parts = node.split(' <-> ')
  nodename = parts[0].to_i
  links = parts[1].split(',')
  network.push(Node.new(nodename))
  links.each do |pipe|
    network[nodename].link(pipe.to_i)
  end
end

puts network
