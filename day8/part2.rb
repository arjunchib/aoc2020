class HandheldConsole
  def initialize(file)
    lines = File.readlines(file)
    @stack = lines.map do |line|
      op, arg = line.split
      [op, arg.to_i]
    end
  end

  def run(stack)
    if (stack == nil)
      stack = @stack
    end
    access_stack = Array.new(stack.length, 0)
    stack_pointer = 0
    acc = 0
    while stack_pointer < stack.length
      break if (access_stack[stack_pointer] > 0)
      op, arg = stack[stack_pointer]
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
    [acc, stack_pointer == stack.length]
  end

  def find_bug
    stack_pointer = 0
    while stack_pointer < @stack.length
      stack = @stack.dup
      op, arg = stack[stack_pointer]
      case op
      when "jmp"
        stack[stack_pointer] = ["nop", arg]
      when "nop"
        stack[stack_pointer] = ["jmp", arg]
      end
      acc, success = run(stack)
      return acc if success
      stack_pointer += 1
    end
  end
end

p HandheldConsole.new("#{__dir__}/example.txt").find_bug
p HandheldConsole.new("#{__dir__}/input.txt").find_bug
