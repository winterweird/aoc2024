#!/bin/bash

cat puzzle.in | rb 'map{_1.chomp.chars}.then { |ls| ls.each_with_index { |l,i| l.each_with_index { |c, j| puts [ls[i-1][j-1]+ls[i+1][j+1], ls[i+1][j-1]+ls[i-1][j+1]].all? { |w| w == "SM" || w == "MS" } if c == "A" && i > 0 && j > 0 &&  i < ls.length-1 && j < l.length-1 } } }' | rb 'grep(/true/).length'
