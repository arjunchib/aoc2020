class HandheldConsole
  def initialize(file)
    lines = File.readlines(file)
    @stack = lines.map do |line|
      op, arg = line.split
      [op, arg.to_i]
    end
  end

  def find_infinite_loop
    access_stack = Array.new(@stack.length, 0)
    stack_pointer = 0
    acc = 0
    while stack_pointer < @stack.length
      break if (access_stack[stack_pointer] > 0)
      op, arg = @stack[stack_pointer]
      access_stack[stack_pointer] += 1
      case op
      when "acc"
        acc += arg
        stack_pointer += 1
      when "jmp"
        stack_pointer += arg
      when "nop"
        stack_pointer += 1
      end
    end
    acc
  end
end

p HandheldConsole.new("#{__dir__}/example.txt").find_infinite_loop
p HandheldConsole.new("#{__dir__}/input.txt").find_infinite_loop
