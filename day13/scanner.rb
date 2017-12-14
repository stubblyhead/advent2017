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

#scanners = [3,2,0,0,4,0,4]

def get_severity(scanners, delay=0)
  severity = 0
  scanners.each_index do |i|
    if (i + delay) % ((scanners[i] - 1) * 2)== 0
      severity += scanners[i] * i
    end
  end
  severity
end

severity = nil
delay = 0
while severity != 0
  severity = get_severity(scanners, delay)
  puts "severity #{severity} at delay #{delay}" if delay == 0 or severity == 0
  delay += 1

end
