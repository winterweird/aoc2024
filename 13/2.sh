#!/bin/bash

cat puzzle.in | rb 'map(&:chomp).reject(&:empty?).each_slice(3).map { |a,b,p| [a.split(/\+|, /).then {|x| [x[1].to_i,x[3].to_i]}, b.split(/\+|, /).then{|x| [x[1].to_i, x[3].to_i]}, p.split(/=|, /).then {|x| [x[1].to_i+10000000000000, x[3].to_i+10000000000000]}] }.map(&:to_s)' | ruby 2.rb | rb 'map(&:to_i).sum'
