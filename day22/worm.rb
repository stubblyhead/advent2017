require 'matrix'
require 'pry'

class Virus
  attr_reader :row, :col, :direction, :infections

  def initialize(grid)
    @col = (grid.column_count / 2)
    @row = (grid.row_count / 2)
    @direction = :up
    @infections = 0
  end

  def turn_left()
    case @direction
    when :up
      @direction = :left
    when :left
      @direction = :down
    when :down
      @direction = :right
    when :right
      @direction = :up
    end
  end

  def turn_right()
    case @direction
    when :up
      @direction = :right
    when :right
      @direction = :down
    when :down
      @direction = :left
    when :left
      @direction = :up
    end
  end

  def move(grid)
    case @direction
    when :up
      @row -= 1
    when :right
      @col += 1
    when :down
      @row += 1
    when :left
      @col -= 1
    end
    if @col == -1
      grid = Matrix.hstack(Matrix.column_vector(Array.new(grid.row_count) { '.' }) , grid)
      @col = 0
    elsif @col == grid.column_count
      grid = Matrix.hstack(grid, Matrix.column_vector(Array.new(grid.row_count) { '.' } ))
    elsif @row == -1
      grid = Matrix.vstack(Matrix.row_vector(Array.new(grid.column_count) { '.'} ), grid)
      @row = 0
    elsif @row == grid.row_count
      grid = Matrix.vstack(grid, Matrix.row_vector(Array.new(grid.column_count) { '.' } ))
    end
    grid
  end


  def burst(grid)
    if grid[@row, @col] == '#'
      #disinfect
      turn_right()
      temp = grid.to_a
      temp[@row][@col] = '.'
      grid = Matrix[*temp]
    else
      #infect
      turn_left()
      temp = grid.to_a
      temp[@row][@col] = '#'
      grid = Matrix[*temp]
      @infections += 1
    end
    grid = move(grid)

    grid
  end
end

def print_grid(grid)
  (0..grid.row_count - 1).each do |i|
    puts grid.row(i).to_a.join(' ')
  end
end


input = Matrix[['.','.','#'],
               ['#','.','.'],
               ['.','.','.']]

morris = Virus.new(input)
binding.pry
70.times { input = morris.burst(input) }
p morris.infections
