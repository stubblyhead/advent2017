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
  unvisited = {}
  distance[0] = 0
  prev[0] = 0

  network.each do |node|
    if node.id != 0
      distance[node.id] = Float::INFINITY
      prev[node.id] = nil
    end
    unvisited[node.id] = distance[node.id]
  end
  while unvisited.length
    min = unvisited.values.min
    break if min == Float::INFINITY
    min_index = unvisited.key(min)
    unvisited.delete(min_index)
    network[min_index].pipes.each do |pipe|
      alt = distance[min_index] + 1
      if alt < distance[pipe]
        distance[pipe] = alt
        prev[pipe] = min_index
      end
      if unvisited.key?(pipe)
        unvisited[pipe] = distance[pipe]
      end
    end
  end
  return [distance, prev]
end


distance, prev = dijkstra(network)
puts network.length - prev.count(nil)
