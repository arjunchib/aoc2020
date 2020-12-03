def process(file)
  lines = File.readlines(file)
  map = lines.map {|line| line.strip.chars}
  sled(map)
end

def sled(map)
  row,col = 0,0
  width = map[0].length
  height = map.length
  trees = 0
  while row < height do
    if map[row][col] == '#'
      trees += 1
    end
    row += 1
    col = (col + 3) % width
  end
  trees
end

puts process("#{__dir__}/example.txt")
puts process("#{__dir__}/input.txt")
