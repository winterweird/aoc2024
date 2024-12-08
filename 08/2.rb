def ac(coords)
  coords.combination(2).flat_map do |a,b|
    dx = a[0]-b[0]
    dy = a[1]-b[1]

    50.times.flat_map do |i|
      [
        [a[0]-dx*i,a[1]-dy*i],
        [a[0]+dx*i,a[1]+dy*i],
        [b[0]-dx*i,b[1]-dy*i],
        [b[0]+dx*i,b[1]+dy*i],
      ]
    end
  end.to_set
end


nodes = eval(gets)
h=gets.to_i
w=gets.to_i

vs = nodes.values.map do |coords|
  vs = ac(coords).select do |c|
    (0...h).include?(c[0]) && (0...w).include?(c[1])
  end
  vs.to_set
end

puts vs.reduce(&:merge).count
