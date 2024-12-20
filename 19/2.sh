#!/bin/bash

cat puzzle.in | rb 'a = to_a; [a.first.chomp.split(", "), a.drop(2).map(&:chomp)].to_s' | ruby 2.rb | rb 'map(&:to_i).sum'
