#!/usr/bin/env ruby

def executable?(path)
  File.executable?(path) && !File.directory?(path)
end

def header(day)
  [
    " #{'='*78} ",
    "|#{"Advent of Code 2024 --- Day #{day.to_i}".center(78)}|",
    " #{'='*78} "
  ].join("\n")
end

days = ARGV
if days.empty?
  days = `ls .`.split(/\s+/).select { _1.match?(/\d+/) }
end
days, invalid_days = days.partition { _1.match?(/\d+/) && File.directory?(_1.rjust(2, "0")) }
if !invalid_days.empty?
  puts "Skipping invalid arguments: #{ invalid_days.join(", ") }"
end
days = days.map { _1.rjust(2, "0") }

days.each do |day|
  part1 = "#{day}/1.sh"
  part2 = "#{day}/2.sh"

  puts header(day)

  if !executable?(part1) && !executable?(part2)
    puts "\nSkipping Day #{day.to_i} --- Not Implemented"
    puts
    next
  end

  puts "\nPart 1: #{executable?(part1) && `cd #{day} && ./1.sh` || "Skipping..."}"
  puts "\n#{'-'*80}"
  puts "\nPart 2: #{executable?(part2) && `cd #{day} && ./2.sh` || "Skipping..."}"
  puts
end

