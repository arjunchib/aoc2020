class ShipNavigator
  def initialize(file)
    @instructions = File.readlines(file).map do |line|
      { action: line[0], value: line[1..-1].to_i }
    end
  end

  def plot_distance
    x = 0
    y = 0
    dir = 0
    @instructions.each do |ins|
      value = ins[:value]
      case ins[:action]
      when 'N'
        y += value
      when 'S'
        y -= value
      when 'E'
        x += value
      when 'W'
        x -= value
      when 'L'
        dir = (dir + value) % 360
      when 'R'
        dir = (dir + (360 - value)) % 360
      when 'F'
        case dir
        when 0
          x += value
        when 90
          y += value
        when 180
          x -= value
        when 270
          y -= value
        end
      end
      # p "#{x}, #{y}, #{dir}"
    end
    x.abs + y.abs
  end
end

p ShipNavigator.new("#{__dir__}/example.txt").plot_distance
p ShipNavigator.new("#{__dir__}/input.txt").plot_distance
