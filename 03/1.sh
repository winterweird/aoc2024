#!/bin/bash

cat puzzle.in | rb -l 'scan(/mul\([0-9]+,[0-9]+\)/)' | rb -l 'gsub(/mul|\(|\)/, "").split(",").map(&:to_i).then { _1 * _2 }' | rb 'map(&:to_i).sum'
