 class RuleGraph
  def initialize(file)
    @edge_list = Hash.new {Array.new}
    lines = File.readlines(file)
    lines.map do |line|
      source, dest_str = line.split(' bags contain ')
      dests = dest_str.scan(/\d+ (.*?) bag/).flatten
      dests.each {|dest| @edge_list[dest] = @edge_list[dest].push(source).uniq}
    end
  end

  def dfs(root)
    frontier = @edge_list[root].dup
    visited = []
    while frontier.length > 0
      v = frontier.pop()
      next if visited.include?(v)
      visited.push(v)
      @edge_list[v].each {|w| frontier.push(w)}
    end
    visited
  end
 end

 p RuleGraph.new("#{__dir__}/example.txt").dfs("shiny gold").length
 p RuleGraph.new("#{__dir__}/input.txt").dfs("shiny gold").length
