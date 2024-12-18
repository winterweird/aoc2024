#!/bin/bash

cat puzzle.in | rb 'map { _1.chomp.split(",").map(&:to_i)}.to_s' | ruby 1.rb 2>/dev/null
