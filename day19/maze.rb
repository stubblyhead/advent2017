def travel(direction, x, y, map, steps)
  #puts "starting at #{x}, #{y} (#{map[y][x]})"
  newdirection = true
  until (map[y][x] == '+' or map[y][x] == ' ') and newdirection == false
    newdirection = false
    #puts "now at #{x}, #{y} (#{map[y][x]})"
    #puts "going #{direction}"
    steps += 1
    case direction
    when :right
      x += 1
    when :left
      x -= 1
    when :up
      y -= 1
    when :down
      y += 1
    end
    print map[y][x] if map[y][x].match(/\w/)
  end
  return [x,y,steps]
end

def turn(direction, x, y, map)
  #puts "was travelling #{direction} at #{x}, #{y}"
  case direction
  when :right
    if y == map.length - 1
      return :up
    else
      left = map [y-1][x]
      right = map[y+1][x]
      if left == ' '
        return :down
      else
        return :up
      end
    end
  when :left
    if y == 0
      return :down
    else
      left = map[y+1][x]
      right = map[y-1][x]
      if left == ' '
        return :up
      else
        return :down
      end
    end
  when :up
    if x == 0
      return :right
    else
      left = map[y][x-1]
      right = map[y][x+1]
      if left == ' '
        return :right
      else
        return :left
      end
    end
  when :down
    if x == map[y].length - 1
      return :left
    else
      left = map[y][x+1]
      right = map[y][x-1]
      if left == ' '
        return :left
      else
        return :right
      end
    end
  end
end

map = []
File.open('./input') do |file|
  file.each_line do |line|
    map.push(line.chomp)
  end
end

x = map[0].index('|')
y = 0
direction = :down
steps = 0
until map[y][x] == ' '
  (x, y, steps) = travel(direction, x, y, map, steps)
  #puts "ended at #{x}, #{y} (#{map[y][x]})"
  direction = turn(direction, x, y, map)
end
puts "\n#{steps} total steps"
