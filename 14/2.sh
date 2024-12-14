#!/bin/bash

cat puzzle.in | rb 'map{_1.chomp.split(/=|,| /).then{|vs| vs.values_at(1,2,4,5).map(&:to_i)}}.to_s' | ruby 2.rb
