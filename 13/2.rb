loop do
  l = eval(gets) rescue (exit 0)

  da, db, ppos = l

  # I choose A x times, then B y times. If I do, I reach my destination. What
  # are x and y?
  #
  # There is some number n such that (P0-A0*n)%B0 == 0 and (P1+A1*n)%B1 == 0
  #
  # n is bounded by (P0/A0).floor, but we can't loop through that many attempts.
  #
  # It's an equation set with two unknowns:
  #
  #   a0 * n + b0 * m = p0
  #   a1 * n + b1 * m = p1
  #
  # n and m are unknowns. We can write m in terms of n:
  #   m = (p0 - a0 * n) / b0
  #
  # Now we can solve for n:
  #   a1 * n + b1 * ((p0 - a0 * n) / b0) = p1
  #   n = (b1*p0 - b0*p1)/(a0*b1 - a1*b0)
  #
  # (I cheated a bit by using Wolfram|Alpha to solve the equation, but I'll take
  # the credit for the idea.)
  #
  # Finally, we can compute m:
  #
  #   m = (p1 - a1 * n) / b1
  #   m = (p1 - a1 * (b1*p0 - b0*p1)/(a0*b1 - a1*b0))
  #
  # If both of these numbers are integers, the answer for this prize is n*3 + m


  n = (db[1]*ppos[0] - db[0]*ppos[1]) / (da[0]*db[1] - da[1]*db[0])
  m = (ppos[0] - da[0] * n) / db[0]

  if [da[0]*n+db[0]*m, da[1]*n+db[1]*m] == ppos
    puts n.to_i * 3 + m.to_i
  end
end
