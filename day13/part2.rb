class BusScheduler
  def initialize(lines)
    @buses = lines
      .split(',')
      .each_with_index
      .reject {|bus, i| bus == 'x'}
      .map {|bus, i| [bus.to_i, -i]}
  end

  def process
    bign = @buses.map {|bus, _| bus}.reduce(:*)
    solutions = @buses.map do |bus, offset|
      n_i = bus
      a_i = offset
      nbar_i = bign / n_i
      u_i = 1
      u_i += 1 until (nbar_i * u_i) % n_i == 1
      a_i * nbar_i * u_i
    end
    sum = solutions.sum
    sum % bign
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

