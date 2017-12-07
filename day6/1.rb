def redistribute(banks)
  redistrib = banks.max
  currentbank = banks.index(redistrib)
  banks[currentbank] = 0
  while redistrib != 0
    currentbank += 1
    #puts "adding to banks[#{currentbank % banks.length}]"
    banks[currentbank % banks.length] += 1
    #puts "banks[#{currentbank % banks.length}] is now #{banks[currentbank % banks.length]}"
    #p banks
    redistrib -= 1
  end
  banks
end
banks = []
File.open('./input') do |file|
  banks = file.readline.split(' ')
end
banks.each_index do |bank|
  banks[bank] = banks[bank].to_i
end

states = []

while true
  nextstate = redistribute(banks)
  if states.index(nextstate)
    puts states.length + 1
    break
  end
  states.push(nextstate.clone)
end
