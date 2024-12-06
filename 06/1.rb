require 'set'

def c?(m,p)
  (0...m.length).include?(p[0]) && (0...m[0].length).include?(p[1])
end

def g(m,p)
  m[p[0]][p[1]]
end

def gn(m,p)
  p2=np(m,p)
  return if !c?(m,p2)
  g(m,p2)
end

def np(m,p)
  steps={"^"=> [-1,0], ">"=> [0,1], "<"=> [0,-1], "v"=> [1,0] }
  ch=g(m,p)
  d = steps[ch]
  [p[0]+d[0], p[1]+d[1]]
end

def rt(c)
  {"^"=> ">", ">"=> "v", "v"=> "<", "<"=> "^"}[c]
end

m = eval(gets)

pos = nil
m.each_with_index {|l, i| l.each_with_index {|c, j| pos = [i,j] if c == "^"}
}
seen = Set.new
loop do
  ch=g(m,pos)

  if seen.include?([pos, ch])
    puts "LOOP"
    exit 1
  end
  seen << [pos, ch]

  n=gn(m,pos)
  if [".", "X",nil].include?(n)
    pos2 = np(m, pos)
    m[pos[0]][pos[1]] = "X"
    m[pos2[0]][pos2[1]] = ch if c?(m, pos2)
    pos = pos2
  elsif n == "#"
    m[pos[0]][pos[1]] = rt(g(m,pos))
  else
    break
  end
  if !c?(m,pos)
    break
  end
end
puts m.map { _1.count("X") }.sum
