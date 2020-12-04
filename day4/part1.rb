def process(file)
  required_fields = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
  lines = File.readlines(file)
  partitions = lines.slice_after {|line| line == "\n"}.to_a
  passports = partitions.map {|p| p.join(' ').delete("\n").strip}
  pp_fields = passports.map {|p| p.split(' ').map {|i| i.split(':')[0]}}
  pp_valid = pp_fields.map {|p| (required_fields - p).count == 0}
  pp_valid.count(true)
end

puts process("#{__dir__}/example.txt")
puts process("#{__dir__}/input.txt")
