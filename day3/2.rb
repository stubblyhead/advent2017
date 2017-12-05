#!/usr/bin/env ruby
target = 0
File.open('./input') do |file|
  target = file.readline.chomp.to_i
end

size = 8 #increase size of grid if last number is too small

size += 1 if size % 2 == 0 #easier to work with odd number height and width
grid = Array.new(size) { Array.new(size,0) } #initialize with 0 so we don't need to check for nils
x,y = size/2,size/2

direction = :right

while grid[y][x] < target
  grid[y][x] = grid[y+1][x] + grid[y+1][x+1] + grid[y][x+1] + grid[y-1][x+1] + grid[y-1][x] + grid[y-1][x-1] + grid[y][x-1] + grid[y+1][x-1] #cell value is equal to sum of all surrounding cells
  grid[y][x] = 1 if grid[y][x] == 0 #if surrounding cells are all zero then it must be the first iteration, so the value is really 1
  if grid[y][x] > target #quit once we find a number greater than the target
    puts grid[y][x]
    break
  end
  case direction
  when :right
    direction = :up if x <= size-1 && grid[y-1][x] == 0
  when :up
    direction = :left if grid[y][x-1] == 0
  when :left
    direction = :down if x == 0 || grid[y+1][x] == 0
  when :down
    direction = :right if grid[y][x+1] == 0
  end

  case direction
  when :right
    x += 1
  when :up
    y -= 1
  when :left
    x -= 1
  when :down
    y += 1
  end


end
