$a = gets.split(" ").last.to_i
$b = gets.split(" ").last.to_i
$c = gets.split(" ").last.to_i
gets
$p = gets.split(" ").last.split(",").map(&:to_i)


# This is my program input:
# 2,4
# 1,5
# 7,5
# 1,6
# 4,3
# 5,5
# 0,3
# 3,0
#
# This represents these instructions:
# while a != 0 do
#   b = a % 8
#   b = b xor 5
#   c = a >> b
#   b = b xor 6
#   b = b xor c
#   puts b % 8
#   a >> 3
# end
#
# To determine what to output at any given step, we can use this equivalent
# formula:
#
# z = a % 8
# z^3^((a>>(z^5))%8)
#
# (There's no real benefit to using this formula instead of writing out all the
# instructions, but I came up with this cryptic almost-one-liner after staring
# at the problem for way too long wondering if I could find a solution
# analytically, and now that I have it, I wanna use it.)
#
# I'm trying to build the solution from the bottom up by varying the last 3
# digits until it works, then trying to look at the next 3. Eventually I run up
# against a wall because, although there are multiple sets of last 3 digits
# which will get me the right answer for the lowermost numbers in the output,
# picking the wrong one makes me end up in a scenario where varying the last 3
# digits does not produce the right output overall.
#
# My hypothesis is that among multiple sets of 3 digits which give me the
# correct answer at the current position, I have to choose the right set of 3
# digits. If at any point I can't find the right number just by varying the last
# 3 digits, it means that a previous set of last 3 digits was wrong.


def prog(n)
  z = n % 8
  z^3^((n>>(z^5))%8)
end

def solutions(p)
  if p.length == 0
    # base case: a is zero, let's step up one level and vary the last 3 digits
    return [0]
  end

  # recursive case:
  # for every solution s to p-1, consider every number such that a >> 3 == s
  # vary the last 3 digits; for any number such that the output at the current
  # step is correct, this is a viable solution for the current step
  # NOTE: incorrect solutions which appear correct at p-1 may be filtered out at
  # this stage: if varying the last 3 digits does not provide a correct output
  # at the step, the solution was never valid to begin with
  partial_solutions = solutions(p[1..])
  partial_solutions.flat_map do |part|
    s = part<<3
    (s..(s+7)).select { |i| prog(i) == p[0] }
  end
end

puts solutions($p).min
