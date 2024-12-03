#!/bin/bash

cat puzzle.in | rb -l 'scan(/mul\([0-9]+,[0-9]+\)|do\(\)|don'"'"'t\(\)/)' | rb 'doing=true; each_with_object([]) { |l, arr| if l.start_with?("mul"); arr << l if doing; elsif l.start_with?("don'"'"'t"); doing = false; else; doing = true; end; }' | rb -l 'gsub(/mul|\(|\)/, "").split(",").map(&:to_i).then { _1 * _2 }' | rb 'map(&:to_i).sum'
