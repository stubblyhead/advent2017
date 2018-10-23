require 'deep_clone'
require 'pry'
require 'matrix'

binding.pry

def split_array(in_array)
  if in_array[0].length % 2 == 0
    num_splits = in_array[0].length / 2
    out_array = Array.new(num_splits) { Array.new(num_splits) { nil } }
    temp_matrix = Matrix[*in_array]
    (0..(num_splits - 1)).each do |i|
      (0..(num_splits - 1)).each do |j|
        out_array[i][j] = temp_matrix.minor(i*2,2,j*2,2).to_a
      end
    end
  else
    num_splits = in_array[0].length / 3
    out_array = Array.new(num_splits) { Array.new(num_splits) { nil } }
    temp_matrix = Matrix[*in_array]
    (0..(num_splits - 1)).each do |i|
      (0..(num_splits - 1)).each do |j|
        out_array[i][j] = temp_matrix.minor(i*3,3,j*3,3).to_a
      end
    end
  end
  out_array
end

patterns = File.readlines('./testcase')
patterns.each_index do |line|
  patterns[line] = patterns[line].chomp.split(' => ')
  patterns[line].each_index do |i|
    patterns[line][i] = patterns[line][i].split('/')
    patterns[line][i].each_index { |j| patterns[line][i][j] = patterns[line][i][j].split('')}
  end
end
rulehash = {}
patterns.each do |i|
  base = i[0]
  transpose_base = DeepClone.clone(base.transpose)
  rotations_flips = []

  rotations_flips.push(base)
  rotations_flips.push(base.reverse)
  rotations_flips.push(DeepClone.clone(base).each { |j| j.reverse! })
  rotations_flips.push(DeepClone.clone(base.reverse).each { |j| j.reverse! })
  rotations_flips.push(transpose_base)
  rotations_flips.push(transpose_base.reverse)
  rotations_flips.push(DeepClone.clone(transpose_base).each { |j| j.reverse! })
  rotations_flips.push(DeepClone.clone(transpose_base.reverse).each { |j| j.reverse! })
  rotations_flips.uniq!
  rulehash[rotations_flips] = i[1]
end

enhance = [['.', '#', '.'],
          ['.', '.', '#'],
          ['#', '#', '#']]

(1..2).each do |i|
  subary = split_array(enhance)
  temp_enhance = Array.new(subary.length) { Array.new(subary.length) { nil } }
  subary.each_index do |j|
    subary[j].each_index do |k|
      rulehash.keys.each do |l|
        temp_enhance[j][k] = rulehash[l] if l.index(subary[j][k])
      end
    end
  end
  #binding.pry
  enhance = temp_enhance[0][0]
  p enhance
end

p enhance
