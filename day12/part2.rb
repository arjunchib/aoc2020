class Position
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def move(x, y)
    @x += x
    @y += y
  end

  def rotate(dir)
    x = @x
    y = @y
    case dir % 360
    when 90
      @x = -y
      @y = x
    when 180
      @x = -x
      @y = -y
    when 270
      @x = y
      @y = -x
    end
  end

  def distance
    @x.abs + @y.abs
  end

  def to_s
    "#{@x}, #{@y}"
  end
end

class ShipNavigator
  def initialize(file)
    @instructions = File.readlines(file).map do |line|
      { action: line[0], value: line[1..-1].to_i }
    end
    @waypoint = Position.new(10, 1)
    @position = Position.new(0, 0)
  end

  def plot_distance
    @instructions.each do |ins|
      value = ins[:value]
      case ins[:action]
      when 'N'
        @waypoint.move(0, value)
      when 'S'
        @waypoint.move(0, -value)
      when 'E'
        @waypoint.move(value, 0)
      when 'W'
        @waypoint.move(-value, 0)
      when 'L'
        @waypoint.rotate(value)
      when 'R'
        @waypoint.rotate(-value)
      when 'F'
        x = @waypoint.x * value
        y = @waypoint.y * value
        @position.move(x, y)
      end
    end
    @position.distance
  end
end

p ShipNavigator.new("#{__dir__}/example.txt").plot_distance
p ShipNavigator.new("#{__dir__}/input.txt").plot_distance
