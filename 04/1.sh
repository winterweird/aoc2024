#!/bin/bash

cat puzzle.in | rb 'def aw(a, i, j); ((-1..1).to_a*2).permutation(2).uniq.map { |dx,dy| begin;a[i][j] + a[i+dy][j+dx] + a[i+dy*2][j+dx*2] + a[i+dy*3][j+dx*3] if (0..a.length).include?(i+dy*3) && (0..a[0].length).include?(j+dx*3); rescue Exception=>e; end; } end; map{_1.chomp.chars}.then { |ls| ls.each.with_index.with_object([]) { |(l,i),a| l.each_with_index { |c, j| puts aw(ls,i,j) if c == "X" } } }' | rb 'grep(/XMAS/).count'
