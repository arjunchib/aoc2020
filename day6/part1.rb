class CustomsParser
  def initialize(file)
    lines = File.readlines(file)
    @groups = make_groups(lines)
  end

  def make_groups(lines)
    lines
      .slice_after {|line| line == "\n"}
      .to_a
      .map do |group|
        group.delete("\n")
        group.map {|person| person.delete("\n")}
      end
  end

  def count_ansers()
    @groups.map {|group| group.join.chars.uniq.length}.sum
  end
end

# examlpe
p CustomsParser.new("#{__dir__}/example.txt").count_ansers

# examlpe
p CustomsParser.new("#{__dir__}/input.txt").count_ansers
