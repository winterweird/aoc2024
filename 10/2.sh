#!/bin/bash

cat puzzle.in | rb 'map {_1.chomp.chars.map(&:to_i)}.to_s' | ruby 2.rb | rb 'map(&:to_i).sum'
