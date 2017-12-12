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

def dijkstra(network)
  distance = []
  prev = []
  unvisited = []
  distance[0] = 0
  prev[0] = 0

  network.each do |node|
    if node.id != 0
      distance[node.id] = Float::INFINITY
      prev[node.id] = nil
    end
    unvisited[node.id] = distance[node.id]
  end
  puts unvisited
end


dijkstra(network)
