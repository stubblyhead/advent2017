#!/usr/bin/env ruby
passphrases = []
File.open('./input') do |file|
  file.each_line do |line|
    passphrases.push(line.chomp.split(' '))
  end
end

count = 0
passphrases.each do |line|
  count += 1 if line.uniq == line
end

puts count
