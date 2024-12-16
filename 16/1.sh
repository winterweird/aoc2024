#!/bin/bash

cat puzzle.in | rb 'map {_1.chomp.chars}.to_s' | ruby 1.rb  2>/dev/null
