#!/bin/bash

cat puzzle.in | rb 'map { |l| l.split(/ +/).map(&:to_i).each_cons(2).map { |i, j| if (i-j).abs < 4 then i - j  else 0  end }.map{_1<=>0}.uniq }.select{_1.length == 1 }.map{_1.first.abs}.sum'
