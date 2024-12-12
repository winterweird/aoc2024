m = eval(gets)

visited = Array.new(m.length) { Array.new(m[0].length) { false } }

def neighbors(m,i,j)
  [[0,1],[0,-1],[1,0],[-1,0]].map { |dx,dy| [i+dy,j+dx] }
end

def ff(m,i,j,visited)
  stack = [[i,j]]
  n = 0 # number of cells
  p = 0 # length of perimeter
  while !stack.empty?
    a,b = stack.pop
    next if visited[a][b]
    visited[a][b] = true
    n += 1
    neighbors(m, a, b).each do |y,x|
      if (0...m.length).include?(y) && (0...m[0].length).include?(x) && m[i][j] == m[y][x]
        stack << [y,x] if !visited[y][x]
      else
        p += 1
      end
    end
  end
  return n,p
end


m.each_with_index do |l,i|
  m.each_with_index do |l, j|
    if !visited[i][j]
      n,p = ff(m,i,j,visited)
      puts n*p
    end
  end
end
