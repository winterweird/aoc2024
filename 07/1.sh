#!/bin/bash

cat puzzle.in | rb 'results, operands = map {a,b = _1.split(":"); [a.to_i, b.split(" ").map(&:to_i)]}.transpose; [results.to_s, operands.to_s]' | ruby 1.rb | rb 'map(&:to_i).sum'
