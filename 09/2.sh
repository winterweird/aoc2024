#!/bin/bash



read -r -d '' s1 <<SRC
debug=false;
slots=[]; l = {}; chars.map(&:to_i).each_slice(2).with_index { |(f,s),i|  f.times { slots << i}; l[slots.length] = s if s;s&.times {slots << nil};  };
STDERR.puts l if debug;
l = l.to_a
loop { break if !slots.last.nil?; slots.pop; };
ix=slots.length-1;
processed = Set.new;
loop do;
    STDERR.puts slots.map(&:to_s).join(", ") if debug;
    v = [slots.delete_at(ix)];
    r = ix - 1;
    loop {break if slots[r] != v[0]; v<<slots.delete_at(r); r-=1;};

    "v should now contain the thing to be moved";
    if processed.include?(v);
        STDERR.puts "NEXT ON HIT CACHE" if debug;
        slots[r+1,0] = v;
        ix = r;
        next;
    end;
    processed << v;
    "puts v.to_s;";
    if r<0;
        STDERR.puts "LAST ITEM; BREAK" if debug;
        slots[0,0]=v;
        break;
    end;
    pos = l.find {|k,x| k<r&&x>=v.length};
    if pos.nil?;
        STDERR.puts "NEXT ON MISSING SLOT" if debug;
        slots[(r+1)..(r)]=v;
        ix = r;
        loop { break if ix<0||!slots[ix].nil? && slots[ix]!=v[0]; ix-=1 };
        next;
    end;
    STDERR.puts "DEFAULT CASE! PUT #{v} AT #{pos}" if debug;
    slots[pos[0],v.length] = v;
    slots[r+1,0] = [nil]*v.length;
    pos[0]+=v.length;
    pos[1]-=v.length;
    loop {break if !slots.last.nil?; slots.pop};
    loop {break if r<0||!slots[r].nil?; r-=1};
    ix=r;
end;
slots.each.with_index.map { |a,b| a.to_i*b}.sum
SRC


read -r -d '' s2 <<SRC
debug=false;
slots=[]; l = {}; chars.map(&:to_i).each_slice(2).with_index { |(f,s),i|  f.times { slots << i}; l[slots.length] = s if s;s&.times {slots << nil};  };
STDERR.puts l if debug;
loop { break if !slots.last.nil?; slots.pop; };
ix=slots.length-1;
processed = Set.new;
loop do;
    STDERR.puts slots.map(&:to_s).join(", ") if debug;
    v = [slots.delete_at(ix)];
    r = ix - 1;
    loop {break if slots[r] != v[0]; v<<slots.delete_at(r); r-=1;};

    "v should now contain the thing to be moved";
    processed << v;
    "puts v.to_s;";
    if r<0;
        STDERR.puts "LAST ITEM; BREAK" if debug;
        slots[0,0]=v;
        break;
    end;
    pos = l.find {|k,x| k<r&&x>=v.length};
    if pos.nil?;
        STDERR.puts "NEXT ON MISSING SLOT" if debug;
        slots[(r+1)..(r)]=v;
        ix = r;
        loop { break if ix<0||!slots[ix].nil? && slots[ix]!=v[0]; ix-=1 };
        next;
    end;
    STDERR.puts "DEFAULT CASE! PUT #{v} AT #{pos}" if debug;
    slots[pos[0],v.length] = v;
    slots[r+1,0] = [nil]*v.length;
    l[pos[0]] = 0;
    l[pos[0]+v.length]=pos[1]-v.length;
    l = l.sort.to_h
    loop {break if !slots.last.nil?; slots.pop};
    loop {break if r<0||!slots[r].nil?; r-=1};
    ix=r;
end;
slots.each.with_index.map { |a,b| a.to_i*b}.sum
SRC

# I was using the follwoing lines to debug the difference between solution 1 and
# solution 2, since when I kept track of processed items and skipped them, the
# solutions output different results.
# Turns out the reason it failed was that I was processing free spaces in the
# wrong order because looping through a hash uses key-insertion order instead of
# order-by-key; sorting the keys every time made the process quite a bit slower,
# but made it work correctly.
# Converting the hash to a list and modifying the found items in place sped the
# solution up a ridiculous amount.
#x=$(ruby -e 'puts rand(9999999999999999999999)')
#echo "$x"
#echo "$x" | rb -l "$s1"
#echo "$x" | rb -l "$s2"

cat puzzle.in | rb -l "$s1"
