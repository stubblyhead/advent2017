scanners = []
severity = 0

File.open('./input') do |file|
  file.each_line do |line|
    layer,depth = line.split(': ')
    scanners[layer.to_i] = depth.to_i
  end
end

scanners.each_index do |i|
  scanners[i] = 0 if scanners[i] == nil
end

scanners.each_index do |i|
  if i % ((scanners[i] - 1) * 2)== 0
    severity += scanners[i] * i
  end
end

puts severity
