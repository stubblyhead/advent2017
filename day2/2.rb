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
checksum = 0
spreadsheet.each_index do |row|
  spreadsheet[row].each_index do |col|
    spreadsheet[row].each_index do |comp|
      if spreadsheet[row][col] % spreadsheet[row][comp] == 0 && col != comp
        checksum += (spreadsheet[row][col] / spreadsheet[row][comp])
      end
    end
  end
end

puts checksum
