#!/bin/bash

cat puzzle.in | rb 'map{_1.chomp.chars}.to_s' | ruby 2.rb 2 | rb 'map(&:to_i).group_by(&:itself).select{_1>=100}.to_h.transform_values(&:length).values.sum'
