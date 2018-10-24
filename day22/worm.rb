require 'matrix'
require 'pry'

class Virus
  attr_reader :x, :y, :direction, :infections

  def initialize(grid)
    @x = (grid.column_count / 2)
    @y = (grid.row_count / 2)
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
    when :up0
      @y -= 1
    when :right
      @x += 1
    when :down
      @y += 1
    when :left
      @x -= 1
    end
    if @x == -1
      grid = Matrix.hstack(Matrix.column_vector(Array.new(grid.row_count) { '.' } , grid))
      @x = 0
    elsif @x == grid.column_count
      grid = Matrix.hstack(grid, Matrix.column_vector(Array.new(grid.row_count) { '.' } ))
    elsif @y == -1
      grid = Matrix.vstack(Matrix.row_vector((Array.new(grid.column_count) { '.'} ), grid))
      @y = 0
    elsif @y == grid.row_count
      grid = Matrix.vstack(grid, Matrix.row_vector(Array.new(grid.column_count) { '.' } ))
    end
    grid
  end


  def burst(grid)
    if grid[@x, @y] == '#'
      turn_right()
      temp = grid.to_a
      temp[@x][@y] = '.'
      grid = Matrix[*temp]
    else
      turn_left()
      temp = grid.to_a
      temp[@x][@y] = '#'
      grid = Matrix[*temp]
      @infections += 1
    end
    grid = move(grid)

    grid
  end
end

input = Matrix[['.','.','#'],
               ['#','.','.'],
               ['.','.','.']]

morris = Virus.new(input)
7.times { input = morris.burst(input) }

p morris.infections
