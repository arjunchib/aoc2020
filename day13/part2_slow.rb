class BusScheduler
  def initialize(input)
    @buses = {}
    @last_bus = nil
    terms = input.split(',')
    terms.each_with_index do |term, i|
      value = term.to_i
      if i == terms.length - 1
        @last_bus = value
      elsif term != 'x'
        diff = terms.length - i - 1
        @buses[value] = diff % value
      end
    end
  end

  def valid?(term)
    @buses.each.all? do |key, value|
      term % key == value
    end
  end

  def process
    i = @last_bus
    while !valid?(i) do
      i += @last_bus
    end
    i - @buses.values.max
  end
end

input = '13,x,x,41,x,x,x,37,x,x,x,x,x,659,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,19,x,x,x,23,x,x,x,x,x,29,x,409,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,17'

p BusScheduler.new('7,13,x,x,59,x,31,19').process
p BusScheduler.new('17,x,13,19').process
p BusScheduler.new('67,7,59,61').process
p BusScheduler.new('67,x,7,59,61').process
p BusScheduler.new('67,7,x,59,61').process
p BusScheduler.new('1789,37,47,1889').process
# p BusScheduler.new(input).process

