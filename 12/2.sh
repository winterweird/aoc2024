#!/bin/bash

cat puzzle.in | rb 'map{_1.chomp.chars}.to_s' | ruby 2.rb  | rb 'map(&:to_i).sum'
