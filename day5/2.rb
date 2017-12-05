offsets = []
File.open('./input') do |file|
  file.each_line do |line|
    offsets.push(line.chomp.to_i)
  end
end

def jump(offsets, position)
  nextposition = position + offsets[position]
  offsets[position] >=3 ? offsets[position] -= 1 : offsets[position] += 1
  return [offsets, nextposition]
end

position = 0
steps = 0
while position < offsets.length
  offsets, position = jump(offsets,position)
  steps += 1
end

puts steps
