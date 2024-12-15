#!/bin/bash

cat puzzle.in | rb 'a=to_a; m=a.take_while{!_1.chomp.empty?}.map{_1.chomp.chars.flat_map {|c| {"." => "..".chars, "@"=>"@.".chars,"#"=>"##".chars, "O" => "[]".chars }[c] }}; ms=a.drop_while{!_1.chomp.empty?}.flat_map{_1.chomp.chars}; puts m.to_s, ms.to_s' | ruby 2.rb  | rb 'map(&:to_i).sum'
