instructions = []
File.open('./input') do |file|
  file.each_line { |line| instructions.push(line) }
end

registers = {}

instructions.each do |i|
  i.chomp!
  modifier, condition = i.split(' if ')
  modifier.sub!('inc', '+=')
  modifier.sub!('dec', '-=')
  registers[modifier.split(' ')[0]] = 0 unless registers[modifier.split(' ')[0]]
  registers[condition.split(' ')[0]] = 0 unless registers[condition.split(' ')[0]]
  words = modifier.split(' ')
  words[0] = words[0].prepend('registers["').concat('"]')
  modifier = words.join(' ')
  words = condition.split(' ')
  words[0] = words[0].prepend('registers["').concat('"]')
  condition = words.join(' ')
  eval(modifier) if eval(condition)
end

puts registers.values.max
