def process(file)
  required_fields = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
  lines = File.readlines(file)
  partitions = lines.slice_after {|line| line == "\n"}.to_a
  passports = partitions.map {|p| partition_to_passport(p)}
  passports.count {|p| valid?(p)}
end

def partition_to_passport(partition)
 partition
  .join(' ')
  .delete("\n")
  .strip
  .split(' ')
  .map {|i| i.split(':')}
  .to_h
end

def valid?(p)
  byr?(p["byr"]) &&
  iyr?(p["iyr"]) &&
  eyr?(p["eyr"]) &&
  hgt?(p["hgt"]) &&
  hcl?(p["hcl"]) &&
  ecl?(p["ecl"]) &&
  pid?(p["pid"])
end

def byr?(val)
  return false if !/^[0-9]{4}$/.match?(val)
  year = val.to_i
  year >= 1920 && year <= 2002
end

def iyr?(val)
  return false if !/^[0-9]{4}$/.match?(val)
  year = val.to_i
  year >= 2010 && year <= 2020
end

def eyr?(val)
  return false if !/^[0-9]{4}$/.match?(val)
  year = val.to_i
  year >= 2020 && year <= 2030
end

def hgt?(val)
  return false if !/^[0-9]+[a-z]{2}$/.match?(val)
  unit = val.slice(-2, 2)
  scalar = val.slice(0...-2).to_i
  if unit == "cm"
    scalar >= 150 && scalar <= 193
  elsif unit == "in"
    scalar >= 59 && scalar <= 76
  else
    false
  end
end

def hcl?(val)
  /^#[0-9a-f]{6}$/.match?(val)
end

def ecl?(val)
  ["amb","blu","brn","gry","grn","hzl","oth"].include?(val)
end

def pid?(val)
  /^[0-9]{9}$/.match?(val)
end

puts process("#{__dir__}/example_invalid.txt")
puts process("#{__dir__}/example_valid.txt")
puts process("#{__dir__}/input.txt")
