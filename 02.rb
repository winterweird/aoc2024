map{ _1.chomp.split(/ +/).map(&:to_i) }.transpose.then { |x,y| x.map { |i| y.count(i)*i  } }.sum
