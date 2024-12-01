#!/usr/bin/env ruby

days = ARGV
if days.empty?
  days = `ls .`.split(/\s+/).select { _1.match?(/\d+/) }
end
days.map! { _1.rjust(2, "0") }

days.each do |day|
  puts "Advent of Code 2024 --- Day #{day.to_i}"
  puts "-"*80
  puts "Part 1:"
  puts `cd #{day} && ./1.sh`
  puts "-"*80
  puts "Part 2:"
  puts `cd #{day} && ./2.sh`
  puts
end

