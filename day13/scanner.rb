scanners = []

File.open('./input') do |file|
  file.each_line do |line|
    layer,depth = line.split(': ')
    scanners[layer.to_i] = depth.to_i
  end
end

scanners.each_index do |i|
  scanners[i] = 0 if scanners[i] == nil
end

def get_severity(scanners, delay=0)
  caught = false
  severity = 0
  scanners.each_index do |i|
    if (i + delay) % ((scanners[i] - 1) * 2)== 0 && scanners[i] != 0
      severity += scanners[i] * i
      caught = true
    end
  end
  [severity, caught]
end

severity = nil
delay = 0
caught = true

while caught
  severity, caught = get_severity(scanners, delay)
  puts "severity #{severity} at delay #{delay} but caught" if (delay == 0 or severity == 0) && caught
  puts "escaped at delay #{delay}!" unless caught
  delay += 1

end
