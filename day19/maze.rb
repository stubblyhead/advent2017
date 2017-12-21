def travel(direction, x, y, map)
  until map[y,x] == '+' or map[y,x] = ' '
    case direction
    when :right
      x += 1
    when :left
      x -= 1
    when :up
      y += 1
    when :down
      y -= 1
    end
  end
  return [x,y]
end

def turn(direction, map, x, y)
  case direction
  when :right
    if y == map.length - 1
      return :up
    else
      left = map [y-1, x]
      right = map[y+1, x]
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
      left = map[y+1, x]
      right = map[y-1, x]
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
      left = map[y, x-1]
      right = map[y, x+1]
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
      left = [y, x+1]
      right = [y, x-1]
      if left == ' '
        return :left
      else
        return :right
      end
    end
  end
end

map = []
File.open('./testcase') do |file|
  file.each_line do |line|
    map.push(line)
  end
end

start_x = map[0].index('|')
x, y = travel(:down, start_x, 0, map)
direction = turn(:down, x, y, map)
x, y = travel(direction, x, y, map)

puts "#{x}  #{y}"
