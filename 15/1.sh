#!/bin/bash

cat puzzle.in | rb 'a=to_a; m=a.take_while{!_1.chomp.empty?}.map{_1.chomp.chars}; ms=a.drop_while{!_1.chomp.empty?}.flat_map{_1.chomp.chars}; puts m.to_s, ms.to_s' | ruby 1.rb | rb 'map(&:to_i).sum'
