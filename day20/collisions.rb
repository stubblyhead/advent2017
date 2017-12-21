particles = {}

File.open('./testcase') do |file|
  file.each_line do |line|
    particle = line.chomp
    parts = particle.split(', ')
    particles[file.lineno] = [parts[0][3..-2].split(','), parts[1][3..-2].split(','), parts[2][3..-2].split(',')]
  end
end

particles.keys.each do |particle|
  particles[particle].each_index do |component|
    (0..2).each { |i| particles[particle][component][i] = particles[particle][component][i].to_i}
  end
end

p particles
