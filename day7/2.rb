require 'rubytree'

class WeightNode < Tree::TreeNode
  attr_reader :weight

  def initialize(name, content = nil)
    super
    @weight = @content
  end

  def add(child, at_index = -1)
    super
    self.reweight
  end

  def reweight
    @weight = 0
    if has_children?
      children.each { |i| @weight += i.weight }
    end
    @weight += @content
  end
end

yells = []
File.open('./input') do |file|
  file.each_line do |line|
    yells.push(line.chomp)
  end
end

allnames = {}
descendents = {}
allchildren = []
yells.each do |yell|
  parts = yell.split(' -> ') #split each line into name/weight and children (if any)
  name = parts[0].split(' (')[0].chomp
  allnames[name] = parts[0].split(' (')[1].chop.to_i #add each name to hash with value of its weight
  if parts.length > 1
    children = parts[1].split(', ')
    descendents[name] = children
  end
end

descendents.values.each { |kids| allchildren += kids }

root = (allnames.keys - allchildren)[0]


trees = {}
allnames.keys.each do |i|
  trees[i] = WeightNode.new(i, allnames[i])

end

descendents.keys.each do |i|
  descendents[i].each do |j|
    trees[i].add(trees[j])
  end
end

trees[root].each_leaf do |leaf|
  leaf.parentage.each { |i| i.reweight }
end

trees[root].print_tree(level=0, max_depth=nil, block = lambda { |node, prefix| puts "#{prefix} #{node.name} (#{node.weight})"})
