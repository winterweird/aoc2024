#!/bin/bash

cat puzzle.in | rb -l 'slots=[]; l = {}; chars.map(&:to_i).each_slice(2).with_index { |(f,s),i|  f.times { slots << i}; l[slots.length] = s if s;s&.times {slots << nil};  }; ix=slots.length-1;
processed = Set.new;
loop do;
    v = [slots.delete_at(ix)];
    r = ix - 1;
    loop {break if slots[r] != v[0]; v<<slots.delete_at(r); r-=1;};

    "v should now contain the thing to be moved"
    processed << v;
    puts v.to_s
    if r<0;
        slots[0,0]=v;
        break;
    end;
    pos = l.find {|k,x| k<r&&x>=v.length};
    if pos.nil?;
        slots[(r+1)..(r)]=v
        ix = r;
        loop { break if ix<0||!slots[ix].nil? && slots[ix]!=v[0]; ix-=1 };
        next;
    end;
    slots[pos[0],v.length] = v;
    slots[r+1,0] = [nil]*v.length
    l[pos[0]] = 0;
    l[pos[0]+v.length]=pos[1]-v.length;
    loop {break if !slots.last.nil?; slots.pop};
    loop {break if r<0||!slots[r].nil?; r-=1};
    ix=r;
end;
slots.each.with_index.map { |a,b| a.to_i*b}.sum'
