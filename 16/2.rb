require "rubygems"
require "algorithms"

def getorient(dy,dx)
  case [dy,dx]
  when [1,0]
    "S"
  when [-1,0]
    "N"
  when [0,1]
    "E"
  when [0,-1]
    "W"
  end
end
def dijk(m, rp, ep)
  s = Containers::MinHeap.new([[0, *rp, "E", [rp]]])
  y,x = rp
  knownscore = Array.new(m.length) { Array.new(m[0].length) { Float::INFINITY } }
  knownscore[y][x] = 0

  visited = Array.new(m.length) { Array.new(m[0].length) { {"N" => false, "W" => false, "E" => false, "S" => false} } }

  camefrom = Array.new(m.length) { Array.new(m[0].length) { nil } }
  seats = Set.new
  best_path = Float::INFINITY

  while !s.empty?
    cost, y,x, orient, path = s.pop

    STDERR.puts "VISITED #{[y,x]} AT COST #{cost}#{[y,x]==ep ? ' AND TERMINATED': ''}"
    visited[y][x][orient] = true
    if cost > best_path
      return seats.length+1
    end
    if [y,x] == ep
      best_path = cost
      seats |= path
      next
    end
    knownscore[y][x] = cost

    [[1,0],[-1,0],[0,1],[0,-1]].each do |dy,dx|
      ny = y+dy
      nx = x+dx
      next if m[ny][nx] == "#"
      neworient = getorient(dy,dx)
      next if {"E" => "W", "W" => "E", "N" => "S", "S" => "N"}[neworient] == orient
      g = knownscore[y][x] + 1 + (neworient != orient ? 1000 : 0)
      s << [g, ny, nx, neworient, path+[[y,x]]] if !visited[ny][nx][orient]
    end
  end

  y,x = ep
  #cur=camefrom[y][x]
  #ps = []
  #while [cur[0],cur[1]] != rp
  #  STDERR.puts cur.to_s
  #  ps << cur
  #  a,b,o = cur
  #  cur = camefrom[a][b]
  #end
  #STDERR.puts ps.map(&:to_s)
  #m2 = Marshal.load(Marshal.dump(m))
  #ps.each do |a,b,o|
  #  m2[a][b] = case o
  #             when "N" then "^"
  #             when "S" then "v"
  #             when "E" then ">"
  #             when "W" then "<"
  #             end
  #end
  #STDERR.puts m2.map(&:join)
  return seats.length+1

end


m = eval(gets)
rp = nil
ep = nil
m.each_with_index do |l,i|
  l.each_with_index do |c,j|
    rp = [i,j] if c == "S"
    ep = [i,j] if c == "E"
  end
end



STDERR.puts rp.to_s
STDERR.puts ep.to_s
STDERR.puts m.map(&:join)


puts dijk(m, rp, ep)
