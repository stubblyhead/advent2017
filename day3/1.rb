#!/usr/bin/env ruby
target = 0
File.open('./input') do |file|
  target = file.readline.chomp.to_i
end

size = (target**0.5).ceil


def cell(n, x, y, start=1)
  y, x = y - n/2, x - (n - 1)/2
  l = 2 * [x.abs, y.abs].max
  d = y >= x ? l*3 + x + y : l - x - y
  (l - 1)**2 + d + start - 1
end

grid = Array.new(size) { Array.new(size) }
size.times do |x|
  size.times do |y|
    grid[y][x] = cell(size,x,y)
  end
end

center_x, center_y, target_x ,target_y = 0
grid.each_index do |rownum|
  if grid[rownum].include?(1)
    center_y = rownum
    center_x = grid[rownum].index(1)
  end
  if grid[rownum].include?(target)
    target_y = rownum
    target_x = grid[rownum].index(target)
  end
end

puts (target_x-center_x).abs + (target_y-center_y).abs
