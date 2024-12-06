#!/bin/bash

H=$(sha1sum puzzle.in | cut -d' ' -f 1)

stat $H.out 2>&1 > /dev/null || cat puzzle.in | rb 'map{_1.chomp.chars}.then{|m| puts m.length; m.each_with_index {|l,i| l.each_with_index { |c,j|  m[i][j] = "#" if c != "^"; output = `echo '"'"'#{m.inspect}'"'"' | ruby 1.rb`; puts "#{i}, #{j}: #{output.chomp}"; m[i][j] = c; } } }; nil' | tee $H.out
cat $H.out | rb 'grep(/LOOP/).length'
