stream = ''
File.open('./input') do |file|
  stream = file.readline
end
original_length = stream.length
puts original_length

def unescape(instr)
  while instr.index('!')
    escapechar = instr[/!./]
    instr.sub!(escapechar,'')
  end
  instr
end

def findgarbage(instr)
  chararray = instr.split('')
  garbageon = false
  startgarbage = stopgarbage = -1
  chararray.each_index do |charindex|
    if garbageon
      if chararray[charindex] == '>'
        stopgarbage = charindex
        break
      end
    else
      garbageon = true if chararray[charindex] == '<'
      startgarbage = charindex
      next
    end
  end
  return [startgarbage,stopgarbage]
end

stream = unescape(stream)

garbagecount = 0

while stream[/</]
  garbage = findgarbage(stream)
  parts = stream.partition(stream[garbage[0]..garbage[1]])
  stream = parts[0] + parts[2]
  garbagecount += (parts[1].length - 2)
end

puts garbagecount
