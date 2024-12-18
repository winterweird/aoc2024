require "rubygems"
require "algorithms"

input = eval(gets)

WIDTH=71
HEIGHT=71
N = 1024

def h(p, e)
  y1,x1 = p
  y2,x2 = e
  return (y1-y2).abs + (x1-x2).abs
end

def astar(m, s, e)
  tovisit = Containers::MinHeap.new
  tovisit << [0, s]

  costs = Array.new(HEIGHT){Array.new(WIDTH){Float::INFINITY}}
  costs[0][0] = 0

  visited = Array.new(HEIGHT){Array.new(WIDTH){false}}

  while !tovisit.empty?
    c, cur = tovisit.pop
    y,x = cur
    next if visited[y][x]
    visited[y][x] = true
    costs[y][x] = [costs[y][x], c].min
    [[0,-1],[0,1],[1,0],[-1,0]].each do |dy,dx|
      ny = y+dy
      nx = x+dx
      if (0...WIDTH).include?(nx) && (0...HEIGHT).include?(ny)
        g = c + h([ny,nx],e)
        tovisit << [c+1, [ny,nx]] if m[ny][nx]!="#"
      end
    end
  end
  y,x = e
  return costs[y][x]
end

# b = smallest number for which it could conceivably happen
# t = biggest number for which it could conceivably happen
b = 1025 # we know the first 1024 blocks are safe
t = input.length


while b != t do
  mid = (b + t) / 2
  m = Array.new(HEIGHT) { Array.new(WIDTH) { "." } }
  input.take(mid).each do |x,y|
    m[y][x] = "#"
  end

  puts m.map(&:join)
  puts [b, t].to_s

  if astar(m, [0,0], [HEIGHT-1,WIDTH-1]) == Float::INFINITY
    t = mid
  else
    b = mid+1
  end
end
m = Array.new(HEIGHT) { Array.new(WIDTH) { "." } }
input.take(b-1).each do |x,y|
  m[y][x] = "#"
end
puts astar(m, [0,0],[HEIGHT-1,WIDTH-1])
puts b-1
puts input.drop(b-1).first.join(",")

