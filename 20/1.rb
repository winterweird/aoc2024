require "rubygems"
require "algorithms"

DIRECTIONS = [[1,0],[-1,0],[0,1],[0,-1]]

def h(p,e)
  y1,x1 = p
  y2,x2 = e
  (y1-y2).abs+(x1-x2).abs
end
def astar(m,s,e)
  ps = Containers::MinHeap.new
  ps << [0, 0,s]

  visited = Array.new(m.length){Array.new(m[0].length){false}}

  while !ps.empty?
    est,c,p = ps.pop

    if p == e
      return c
    end

    y,x = p

    next if visited[y][x]
    visited[y][x] = true

    DIRECTIONS.each do |dy,dx|
      ny = y+dy
      nx = x+dx
      if (0...m.length).include?(ny) && (0...m.length).include?(nx)
        ps << [est+h([ny,nx],e),c+1,[ny,nx]] if m[ny][nx]!="#"&&!visited[ny][nx]
      end
    end
  end
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

saved_counts={}
default_len = astar(m,s,e)

m.each_with_index do |l,i|
  l.each_with_index do |c,j|
    if c == "#"
      m[i][j] = "1"
      DIRECTIONS.each do |dy,dx|
        ny=i+dy
        nx=j+dx
        if (0...m.length).include?(ny) && (0...l.length).include?(nx) && m[ny][nx]!="#"
          tmp = m[i][j]
          m[i][j] = "2"
          new_len = astar(m,s,e)
          diff=default_len-new_len
          puts diff
          STDOUT.flush
          saved_counts[diff]||=0
          saved_counts[diff]+=1
          #total += 1 if astar(m,s,e)>=100
          m[i][j]=tmp
        end
      end
      m[i][j]="#"
    end
  end
end

#THRESHOLD=100
## Not sure why but it works
#saved_counts = saved_counts.map{[_1,_2/4]}.sort.to_h
#puts saved_counts
#
#puts saved_counts.select{_1>=THRESHOLD}.to_h.values.sum
