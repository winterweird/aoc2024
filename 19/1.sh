#!/bin/bash

cat puzzle.in | rb 'a = to_a; cs,ps = [a.first.chomp.split(", "), a.drop(2).map(&:chomp)]; ps.map{|p| /^(#{cs.join("|")})*$/.match?(p)}' | rb 'grep(/true/).length'
