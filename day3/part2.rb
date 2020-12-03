def process(file)
  lines = File.readlines(file)
  map = lines.map {|line| line.strip.chars}
  trees = [
    sled(map, 1, 1),
    sled(map, 3, 1),
    sled(map, 5, 1),
    sled(map, 7, 1),
    sled(map, 1, 2)
  ]
  trees.reduce(:*)
end

def sled(map, right, down)
  row,col = 0,0
  width = map[0].length
  height = map.length
  trees = 0
  while row < height do
    if map[row][col] == '#'
      trees += 1
    end
    row += down
    col = (col + right) % width
  end
  trees
end

puts process("#{__dir__}/example.txt")
puts process("#{__dir__}/input.txt")
