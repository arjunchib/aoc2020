 class RuleGraph
  def initialize(file)
    @edge_list = Hash.new {Array.new}
    lines = File.readlines(file)
    lines.map do |line|
      source, dest_str = line.split(' bags contain ')
      dests = dest_str.scan(/(\d+) (.*?) bag/).map {|weight,v| [weight.to_i, v]}
      @edge_list[source] = @edge_list[source].concat(dests).uniq
    end
  end

  def dfs(root)
    frontier = @edge_list[root].dup
    visited = []
    while frontier.length > 0
      weight, bag = frontier.pop()
      visited.push([weight, bag])
      @edge_list[bag].each {|w,b| frontier.push([w * weight,b])}
    end
    visited
  end

  def count_bags(root)
    dfs(root).reduce(0) {|sum, (weight, bag)| sum += weight}
  end
 end

 p RuleGraph.new("#{__dir__}/example.txt").count_bags("shiny gold")
 p RuleGraph.new("#{__dir__}/input.txt").count_bags("shiny gold")
