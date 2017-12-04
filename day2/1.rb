#!/usr/bin/env ruby
spreadsheet = []
File.open('./input') do |file|
  file.each_line do |line|
    spreadsheet.push(line.chomp.split(' '))
  end
end
spreadsheet.each_index do |row|
  spreadsheet[row].each_index { |item| spreadsheet[row][item] = spreadsheet[row][item].to_i }
end
#spreadsheet = [[5,1,9,5],[7,5,3],[2,4,6,8]]
checksum = 0
spreadsheet.each do |row|
  checksum += (row.max.to_i - row.min.to_i)
end

puts checksum
