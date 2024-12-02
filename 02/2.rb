def safe?(line)
  safe = [[1],[-1]];
  safe.include?(line.each_cons(2).map { |i,j| ((i-j).abs < 4 ? i-j : 0)<=>0 }.uniq);
end;

ls = self.map { |l| l.split(/ +/).map(&:to_i) };
ls.each do |l|
  if safe?(l);
    puts 1;
    next;
  end;

  l.each_with_index do |v, i|;
    l2 = [*l];
    l2.delete_at(i);
    if safe?(l2);
      puts 1;
      break;
    end;
  end;
end;
nil
