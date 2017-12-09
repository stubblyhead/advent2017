yells = []
File.open('./input') do |file|
  file.each_line do |line|
    yells.push(line.chomp)
  end
end

allnames = []
descendents = []
yells.each do |yell|
  parts = yell.split(' -> ')
  name = parts[0].split(' (')[0].chomp
  allnames.push(name.clone)
  if parts.length > 1
    children = parts[1].split(', ')
    descendents += children
  end
end

#p allnames
#p descendents
puts allnames - descendents
