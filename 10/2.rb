def neighbors(m,i,j)
  [[0,1],[0,-1],[1,0],[-1,0]].map { |dx,dy| [i+dy,j+dx] }.filter do |y,x|
    (0...m.length).include?(y) && (0...m[0].length).include?(x) && m[y][x] == m[i][j]+1
  end
end

def bfs(m,i,j)
  visited = Array.new(m.length) { Array.new(m[0].length) {false} }
  stack = [[i,j]]
  while !stack.empty?
    n = stack.pop
    visited[n[0]][n[1]] = true
    puts 1 if m[n[0]][n[1]] == 9
    neighbors(m, *n).each do |p|
      stack << p
    end
  end
end
input = eval(gets)

puts input.map(&:to_s)


input.each_with_index do |l,i|
  l.each_with_index do |c,j|
    bfs(input, i,j) if c == 0
  end
end

