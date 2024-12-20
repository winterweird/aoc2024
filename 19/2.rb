cs, ps = eval(gets)

$memo = {}

def rec(p,cs)
  $memo[p] ||= cs.select { p.start_with?(_1) }.map{ p==_1 ? 1 : rec(p.sub(_1,""), cs) }.sum
end

ps.each do |p|
  puts $memo[p] ||= rec(p,cs)
end
