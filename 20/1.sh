#!/bin/bash

H=$(sha1sum puzzle.in | cut -d' ' -f 1)
stat $H.out &>/dev/null || \
    cat puzzle.in | rb 'map{_1.chomp.chars}.to_s' | ruby 1.rb | tee $H.out
cat $H.out | rb 'map(&:to_i).group_by(&:itself).transform_values{|a|a.length/2}.select{_1>=100}.to_h.values.sum'

