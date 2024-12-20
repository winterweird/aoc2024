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
  # NOTE: not actually astar, but whatever
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

m = Array.new(HEIGHT) { Array.new(WIDTH) { "." } }
input.take(N).each do |x,y|
  m[y][x] = "#"
end

STDERR.puts m.map(&:join)

puts astar(m, [0,0], [HEIGHT-1,WIDTH-1])
