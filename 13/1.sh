#!/bin/bash

cat puzzle.in | rb 'map(&:chomp).reject(&:empty?).each_slice(3).map { |a,b,p| [a.split(/\+|, /).then {|x| [x[1].to_i,x[3].to_i]}, b.split(/\+|, /).then{|x| [x[1].to_i, x[3].to_i]}, p.split(/=|, /).then {|x| [x[1].to_i, x[3].to_i]}] }.map(&:to_s)' | ruby 1.rb | rb 'map(&:to_i).sum'
