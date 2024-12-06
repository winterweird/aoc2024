#!/bin/bash

cat puzzle.in | rb 'map{_1.chomp.chars}.inspect' | ruby 1.rb
