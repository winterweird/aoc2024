#!/usr/bin/env ruby

input = STDIN.gets
s = input.split(" ").map(&:to_i)

def length_even?(n)
  Math.log10(n).to_i.odd?
end

def div(n)
  10**(Math.log10(n)/2).ceil
end

lookup = {}

def len(n, t, lookup)
  lookup[[n,t]] ||=
    if t == 0
      1
    elsif n == 0
      len(1,t-1,lookup)
    elsif length_even?(n)
      v = div(n)
      len((n/v).to_i, t-1,lookup) + len(n-(n/v).to_i*v, t-1,lookup)
    else
      len(n*2024, t-1,lookup)
    end
end

t = ARGV[0].to_i

puts s.map { len(_1, t, lookup) }.sum


