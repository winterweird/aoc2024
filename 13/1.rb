loop do
  l = eval(gets) rescue (exit 0)

  da, db, ppos = l


  100.times do |i|
    100.times do |j|
      if [da[0]*i+db[0]*j, da[1]*i+db[1]*j] == ppos
        puts i*3 + j
      end
    end
  end
end
