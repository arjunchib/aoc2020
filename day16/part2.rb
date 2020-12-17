class Ticket
  attr_reader :values

  def initialize(input)
    @values = input.split(',').map {|i| i.to_i}
  end

  def valid?(rule)
    @values.any? {|v| rule.valid?(v) }
  end

  def valid_at?(rule, index)
    rule.valid?(@values[index])
  end

  def invalid_values(rules)
    @values.select do |value|
      rules.all? {|r| !r.valid?(value)}
    end
  end
end

class Rule
  attr_reader :name

  def initialize(input)
    match = /^([a-z ]+): (\d+)-(\d+) or (\d+)-(\d+)$/.match(input)
    @name = match[1]
    @ranges = [match[2].to_i..match[3].to_i, match[4].to_i..match[5].to_i]
  end

  def valid?(value)
    @ranges.any? {|r| r.include?(value)}
  end
end

class TicketScanner
  def initialize(file)
    inputs = File.readlines(file, chomp: true).slice_after(/$^/).to_a
    @rules = inputs[0][0..-2].map {|i| Rule.new(i)}
    @my_ticket = Ticket.new(inputs[1][1])
    @nearby_tickets = inputs[2][1..-1].map {|i| Ticket.new(i)}
  end

  def error_rate
    @nearby_tickets.map {|t| t.invalid_values(@rules)}.flatten.sum
  end

  def rules_map # please ignore this horrid abomination
    num_values = @my_ticket.values.length
    valid_nearby_tickets = @nearby_tickets.reject {|t| t.invalid_values(@rules).length > 0}
    tickets = [@my_ticket, *valid_nearby_tickets]
    rule_map = Hash.new {|hash, key| hash[key] = Array.new}
    @rules.each do |rule|
      (0...num_values).each do |i|
        if tickets.all? {|t| t.valid_at?(rule, i)}
          rule_map[rule.name].push(i)
        end
      end
    end
    index_map = {}
    while (0...num_values).any? {|i| !index_map.include?(i)} do
      singles = rule_map.values.flatten.group_by {|x| x}.select {|k, v| v.length == 1}.values.map {|x| x.first}
      rule_map.each do |rule_name, indexs|
        if indexs.length == 1
          index = indexs.pop
          index_map[index] = rule_name
          rule_map.each_value {|value| value.delete(index)}
          indexs.clear
        end
        if (singles & indexs).length == 1
          index = (singles & indexs)[0]
          index_map[index] = rule_name
          indexs.clear
        end
      end
    end
    index_map
  end

  def departure_score
    departure_rules = rules_map.select do |index, rule|
      rule.start_with?('departure')
    end
    departures = departure_rules.map do |index, rule|
      @my_ticket.values[index]
    end
    p departures
    departures.reduce(:*)
  end
end

p TicketScanner.new("#{__dir__}/example2.txt").rules_map
p TicketScanner.new("#{__dir__}/input.txt").departure_score
