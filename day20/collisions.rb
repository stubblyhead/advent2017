particles = {}

File.open('./input') do |file|
  file.each_line do |line|
    particle = line.chomp
    parts = particle.split(', ')
    particles[file.lineno-1] = [parts[0][3..-2].split(','), parts[1][3..-2].split(','), parts[2][3..-2].split(',')]
  end
end

particles.keys.each do |particle|
  particles[particle].each_index do |component|
    (0..2).each { |i| particles[particle][component][i] = particles[particle][component][i].to_i}
  end
end

def step(particles)
  particles.keys.each do |particle|
    (0..2).each do |i|
      particles[particle][1][i] = particles[particle][1][i] + particles[particle][2][i]
      particles[particle][0][i] += particles[particle][1][i]
    end
  end
  return particles
end

def collide(particles)
  particles.keys.each do |particle|
    found_collision = false
    position = particles[particle][0]
    #p "particle #{particle} position:  #{position}"
    particles.keys.each do |fuck|
      if particle != fuck && particles[fuck][0] == position
        #puts "base position: #{position}\ncomp position: #{particles[fuck][0]}"
        particles.delete(fuck)
        found_collision = true
      end
    end
    #puts "collision found :#{found_collision}"
    if found_collision
      particles.delete(particle)
      break
    end
    #p "remaining keys:  #{particles.keys}"
  end
  return particles
end

(1..50).each do |i|
  start_particles = particles.length
  particles = step(particles)
  particles = collide(particles)
  end_particles = particles.length
  puts "#{start_particles - end_particles} particles removed on iteration #{i}" if start_particles != end_particles
end

puts particles.length
