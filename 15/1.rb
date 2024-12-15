m = eval(gets)
ms = eval(gets)

DEBUG = false

rp = nil
m.each.with_index do |l,i|
  j = l.index("@")
  if j
    rp = [i,j]
    break
  end
end


dirs ={
  ">" => [0,1],
  "<" => [0,-1],
  "^" => [-1,0],
  "v" => [1,0],
}
ms.each do |move|
  STDERR.puts move.to_s if DEBUG
  dy,dx = dirs[move]
  STDERR.puts [dy,dx] if DEBUG
  ps = []
  STDERR.puts m.map(&:join) if DEBUG
  100000.times do |i|
    c = m[rp[0]+dy*i][rp[1]+dx*i]
    if c == "#"
      ps = []
      break
    end


    ps << [rp[0]+dy*i,rp[1]+dx*i]
    break if c == "."
  end

  if !ps.empty?
    ps.reverse.each_cons(2) do |(ay,ax),(by,bx)|
      STDERR.puts "MOVE #{m[ay][ax]} TO #{m[by][bx]}" if DEBUG
      m[ay][ax] = m[by][bx]
    end
    m[rp[0]][rp[1]] = "."
    rp = [rp[0]+dy,rp[1]+dx]
  end
end

m.each_with_index do |l,i|
  l.each_with_index do |c, j|
    puts 100*i+j if c == "O"
  end
end
