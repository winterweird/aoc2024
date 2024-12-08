#!/bin/bash

cat puzzle.in | rb 'map{_1.chomp.chars}.then{|a|[a.each.with_index.with_object(Hash.new {|h,k|h[k]=[]}){ |(l,i),h| l.each_with_index{|c,j| h[c]<<[i,j] if c != "."} }, a.length,a.first.length] }' | ruby 1.rb
