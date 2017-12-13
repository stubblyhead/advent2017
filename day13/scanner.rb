scanners = [3,2,0,0,4,0,4]
severity = 0

scanners.each_index do |i|
  if i % ((scanners[i] - 1) * 2)== 0
    puts "hit on level #{i}"
    severity += scanners[i] * i
    puts severity
  end
end

puts severity
