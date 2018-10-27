require 'psych'
require 'pry'

#binding.pry

class Tape
  attr_reader :pointer, :stream, :rules, :current_state, :steps
  def initialize(rules)
    @stream = [0]
    @pointer = 0
    @rules = rules
    @current_state = rules["Begin in state"].chop
    @steps = rules['Perform a diagnostic checksum after'].split[0].to_i
  end

  def pointer_right()
    @pointer += 1
    @stream += [0] if @pointer == @stream.length
  end

  def pointer_left()
    @pointer -= 1
    if @pointer < 0
      @stream = [0] + @stream
      @pointer = 0
    end
  end

  def checksum()
    return @stream.count(1)
  end

  def do_step()
    instructions = @rules["In state #{@current_state}"]["If the current value is #{@stream[@pointer]}"]
    @stream[@pointer] = instructions[0].split[-1].to_i
    direction = instructions[1].split[-1].chop
    send("pointer_#{direction}")
    @current_state = instructions[2].split[-1].chop
  end

  def run()
    steps.times { do_step }
  end

end

#input is practically yaml, so make it actual yaml
lines = []
File.open('./input') { |file| lines = file.readlines }
lines[0].sub!(/state/, 'state:')
lines[1].sub!(/after/, 'after:')

rules = Psych.load(lines.join)
turing = Tape.new(rules)

turing.run
puts turing.checksum
