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

network = {}
networkmap.each do |node|
  parts = node.split(' <-> ')
  nodename = parts[0].to_i
  links = parts[1].split(',')
  network[nodename] = Node.new(nodename)
  links.each do |pipe|
    network[nodename].link(pipe.to_i)
  end
end

def dijkstra(network, origin)
  distance = {}
  prev = {}
  unvisited = {}
  distance[origin] = 0
  prev[origin] = 0
  network.values.each do |node|
    if node.id != origin
      distance[node.id] = Float::INFINITY
      prev[node.id] = nil
    end
    unvisited[node.id] = distance[node.id]
  end
  while unvisited.length > 0
    min = unvisited.values.min
    break if min == Float::INFINITY
    min_index = unvisited.key(min)
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
    unvisited.delete(min_index)
  end
  return [distance, prev]
end
groupcount = 0
while network.length > 0
  nextnode = network.keys.min
  distance, prev = dijkstra(network,network[nextnode].id)
  network.delete_if {|key,val| prev[val.id] != nil}
  groupcount += 1
end

puts groupcount
