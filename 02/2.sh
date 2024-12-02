#!/bin/bash

cat puzzle.in | rb 'def check?(l); [[1], [-1]].include?(l.each_cons(2).map{|i,j| ((i-j).abs < 4 ? i-j : 0)<=>0}.uniq); end; def safe?(l); check?(l) || (0...l.length).any?{|i| check?(l.reject.with_index{|_,j| j == i})}; end; map { |l| l.split(/ +/).map(&:to_i) }.select{|l| safe?(l)}.length'
