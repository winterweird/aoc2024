require 'pp'


m = eval(gets)
ms = eval(gets)

DEBUG = false

STDERR.puts m.map(&:join) if DEBUG

STDERR.puts(ms.join) if DEBUG


rp = nil
m.each.with_index do |l,i|
  j = l.index("@")
  if j
    rp = [i,j]
    break
  end
end

def find_moved_positions(m,y,x,dy,dx,trails,visited)
  if m[y][x] == "#"
    throw Exception.new("wall")
  end

  return if visited[y][x]

  trail = trails.pop
  #STDERR.puts "CHECKING #{[y,x]} = #{m[y][x]}, MOVING WITH #{[dy,dx]}" if DEBUG
  visited[y][x] = true

  if m[y][x] == "."
    trails << (trail << [y,x])
    return
  end

  if m[y][x] == "[" && dy != 0
    STDERR.puts("SPLIT TRAIL! 1") if DEBUG
    find_moved_positions(m,y+dy,x,dy,dx, trails<<(trail<<[y,x]), visited)
    find_moved_positions(m,y+dy,x+1,dy,dx, trails<<[[y,x+1]], visited)
    return
  elsif m[y][x] == "]" && dy != 0
    STDERR.puts("SPLIT TRAIL! 2") if DEBUG
    v1 = find_moved_positions(m,y+dy,x,dy,dx, trails<<(trail<<[y,x]), visited)
    v2 = find_moved_positions(m,y+dy,x-1,dy,dx, trails<<[[y,x-1]], visited)
    return
  else
    find_moved_positions(m,y+dy,x+dx,dy,dx, trails<<(trail<<[y,x]), visited)
  end
end


dirs ={
  ">" => [0,1],
  "<" => [0,-1],
  "^" => [-1,0],
  "v" => [1,0],
}
ms.each do |move|
  STDERR.puts "MOVE: #{move}" if DEBUG
  dy,dx = dirs[move]
  #STDERR.puts [dy,dx].to_s if DEBUG
  ps = [[]]
  STDERR.puts "BEFORE" if DEBUG
  STDERR.puts m.map(&:join) if DEBUG
  y,x = rp
  begin
    find_moved_positions(m, y,x,dy,dx,ps, Array.new(m.length) { Array.new(m[0].length) { false } })
  rescue Exception
    #STDERR.puts e if DEBUG
    STDERR.puts "RESCUE" if DEBUG
    ps=[]
  end
  STDERR.puts "MOVES:::" if DEBUG
  PP.pp(ps, out=STDERR) if DEBUG

  if !ps.empty?
    STDERR.puts "PUSHED SOMETHING" if DEBUG && ps[0].length > 2
    ps.each do |trail|
      trail.reverse.each_cons(2) do |trail_next, trail_prev|
        #STDERR.puts "NEXT: #{trail_next}" if DEBUG
        #STDERR.puts "PREV: #{trail_prev}" if DEBUG
        ay, ax = trail_next
        by, bx = trail_prev
        #STDERR.puts "MOVE #{m[by][bx]} TO #{m[ay][ax]}" if DEBUG
        m[ay][ax] = m[by][bx]
      end
      if trail.length > 1
        ny,nx = trail[0]
        m[ny][nx] = "."
      end
    end
    m[y][x] = "."
    #m[y+dy][x+1] = "."  if dy!=0&&m[y+dy][x+1] == "]"
    #m[y+dy][x-1] = "."  if dy!=0&&m[y+dy][x-1] == "["
    rp = [y+dy,x+dx]
  end
  STDERR.puts "AFTER" if DEBUG
  STDERR.puts m.map(&:join) if DEBUG
  STDERR.puts "=" * 80 if DEBUG
end

m.each_with_index do |l,i|
  l.each_with_index do |c, j|
    if c == "["
      puts i*100 + j
    end
    #puts 100*i+j if c == "O"
  end
end
