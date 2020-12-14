class BusScheduler
  def initialize(input)
    @buses = input.split(',').map do |i|
      i == 'x' ? Float::INFINITY : i.to_i
    end
  end

  def valid?(buses)
    buses.each_with_index.all? do |bus, index|
      bus == Float::INFINITY || buses.first + index == bus
    end
  end

  def process
    buses = @buses.dup
    while !valid?(buses) do
      min, index = buses.each_with_index.min {|a, b| (a[0] - a[1]) <=> (b[0] - b[1]) }
      buses[index] += @buses[index]
    end
    buses.first
  end
end

input = '13,x,x,41,x,x,x,37,x,x,x,x,x,659,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,19,x,x,x,23,x,x,x,x,x,29,x,409,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,17'

p BusScheduler.new('7,13,x,x,59,x,31,19').process
p BusScheduler.new('17,x,13,19').process
p BusScheduler.new('67,7,59,61').process
p BusScheduler.new('67,x,7,59,61').process
p BusScheduler.new('67,7,x,59,61').process
p BusScheduler.new('1789,37,47,1889').process
p BusScheduler.new(input).process

