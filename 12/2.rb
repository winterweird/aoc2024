m = eval(gets)


DEBUG = false

def neighbors(m,i,j)
  [[0,1,"R"],[0,-1,"L"],[1,0,"D"],[-1,0,"U"]].map { |dy,dx,d| [i+dy,j+dx,d] }
end

def ff(m,i,j,visited)
  stack = [[i,j,[]]]
  n = 0 # number of cells
  p = 0 # length of perimeter
  expected_walls_map = Array.new(m.length) { Array.new(m[0].length) { Set.new } }
  STDERR.puts "FLOOD FILLING #{m[i][j]} AT #{[i,j]}" if DEBUG
  while !stack.empty?
    a,b = stack.shift
    next if visited[a][b]
    expected_walled = expected_walls_map[a][b]
    STDERR.puts "VISITED #{[a,b]} WITH EXPECTED WALLS: #{expected_walled}" if DEBUG
    visited[a][b] = true
    STDERR.puts visited.each.with_index.map { |v,c1| v.each.with_index.map { |c,c2| [c1,c2]==[a,b]?"X":c&&m[c1][c2]==m[a][b] ? 1 : 0 }.join(", ") } if DEBUG
    n += 1
    walled = []
    tmp = []
    neighbors(m, a, b).each do |y,x,d|
      if (0...m.length).include?(y) && (0...m[0].length).include?(x) && m[i][j] == m[y][x]
        #STDERR.puts "ADDING #{[y,x]} TO TMP; CHECK EXPECTED WALLED LATER" if DEBUG
        tmp << [y,x,d] if !visited[y][x]
      else
        STDERR.puts "CONFIRMED WALL #{d} AT #{[y,x]}" if DEBUG
        walled << d
      end
    end
    STDERR.puts "WALLED IS: #{ walled }" if DEBUG
    STDERR.puts "EXPECTED WALLED IS: #{expected_walled}" if DEBUG
    walled_unexpected = walled - expected_walled.to_a
    p += walled_unexpected.length
    STDERR.puts "ADDED #{walled_unexpected} AS NEW SIDES (CURRENTLY #{p})" if DEBUG
    expected_walls_map[a][b] |= walled_unexpected.to_set # does not matter?
    tmp.each do |y,x,d|
      case d
      when /[RL]/
        # Prevent double counting walls already in expected walls
        expect_cont = ["U", "D"] & walled
        expect_cont.each do |s|
          if expected_walls_map[y][x].include?(s)
            p -= 1
          end
        end
        expected_walls_map[y][x] |= expect_cont.to_set
        STDERR.puts "MOVING HORIZONTALLY FROM #{[a,b]} TO #{[y,x]}: EXPECTING #{expect_cont} WALLS TO CONTINUE" if DEBUG
        stack << [y,x]
      when /[UD]/
        # Prevent double counting walls already in expected walls
        expect_cont = ["L", "R"] & walled
        expect_cont.each do |s|
          if expected_walls_map[y][x].include?(s)
            p -= 1
          end
        end
        expected_walls_map[y][x] |= expect_cont.to_set
        STDERR.puts "MOVING VERTICALLY FROM #{[a,b]} TO #{[y,x]}: EXPECTING #{expect_cont} WALLS TO CONTINUE" if DEBUG
        stack << [y,x]
      end
    end
  end
  return n,p
end



visited = Array.new(m.length) { Array.new(m[0].length) { false } }
STDERR.puts(m.map(&:join)) if DEBUG
m.each_with_index do |l,i|
  l.each_with_index do |c,j|
    if !visited[i][j]
      n,p = ff(m,i,j,visited)
      STDERR.puts [n,p].to_s if DEBUG
      STDERR.puts n*p if DEBUG
      puts n*p
    end
  end
end
