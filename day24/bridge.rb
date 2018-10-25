components = []
File.open('./input') do |file|
  file.each_line do |line|
    line = line.chomp.split('/')
    line.each_index { |i| line[i] = line[i].to_i }
    components.push(line)
  end
end

starts = []
components.each do |i|
  starts.push(i) if i.index(0)
end

def find_matches(current, used, components)
  matches = []
  current[0] == used ? avail = current[1] : avail = current[0]
  components.each do |i|
    matches.push(i) if i.index(avail) and i != current
  end
  return matches
end

p find_matches(starts[0], 0, components)
