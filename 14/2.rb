rs = eval(gets)

WIDTH=101
HEIGHT=103
N = 10000

N.times do |i|
  m = Array.new(103) { Array.new(101) { " " } }
  rs.each do |x,y,dx,dy|
    px,py = (x+dx*i)%WIDTH, (y+dy*i)%HEIGHT
    m[py][px] = "x"
  end
  if m.any? { |l| l.join.include?("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx") }
    puts i
    break
  end
end
