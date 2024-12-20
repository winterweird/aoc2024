require "rubygems"
require "algorithms"

DIRECTIONS = [[1,0],[-1,0],[0,1],[0,-1]]
CHEAT_LENGTH=20

def h(p,e)
  y1,x1 = p
  y2,x2 = e
  (y1-y2).abs+(x1-x2).abs
end
def dijk(m,s)
  ps = Containers::MinHeap.new
  ps << [0, s]

  costs = Array.new(m.length){Array.new(m[0].length){Float::INFINITY}}
  costs[s[0]][s[1]] = 0
  visited = Array.new(m.length){Array.new(m[0].length){false}}

  while !ps.empty?
    c,p = ps.pop

    y,x = p

    next if visited[y][x]
    visited[y][x] = true
    costs[y][x] = c

    DIRECTIONS.each do |dy,dx|
      ny = y+dy
      nx = x+dx
      if (0...m.length).include?(ny) && (0...m[0].length).include?(nx)
        ps << [c+1,[ny,nx]] if m[ny][nx]!="#"&&!visited[ny][nx]
      end
    end
  end
  return costs
end

m = eval(gets)
s=nil
e=nil
m.each_with_index do |l,i|
  l.each_with_index do |c,j|
    s=[i,j] if c=="S"
    e=[i,j] if c=="E"
  end
end

c_s = dijk(m, s)
c_e = dijk(m, e)

default_len = c_s[e[0]][e[1]]

m.each_with_index do |l,i|
  l.each_with_index do |c,j|
    next if c == "#"
    (-CHEAT_LENGTH..CHEAT_LENGTH).each do |dy|
      (-CHEAT_LENGTH..CHEAT_LENGTH).each do |dx|
        next if dy==0&&dx==0
        ny = i+dy
        nx = j+dx
        next if !((0...m.length).include?(ny) && (0...m[0].length).include?(nx))
        next if m[ny][nx] == "#"
        hdiff = h([i,j],[ny,nx])
        next if hdiff > CHEAT_LENGTH
        new_len = c_s[i][j] + hdiff + c_e[ny][nx]
        diff = default_len - new_len
        puts diff
      end
    end
  end
end
