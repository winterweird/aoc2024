#!/bin/bash

cat puzzle.in | rb 'updates = nil; rules = nil; m = Hash.new {|h,k| h[k]=[]}; to_a.then { |a| rules = a.take_while { |i| !i.chomp.empty? }.map { |l| l.chomp.split("|") }; updates = a.drop_while { |i| !i.chomp.empty? }.drop(1).map { |l| l.chomp.split(",") }; }; rules.each { |k, v| m[k] << v; }; updates.reject { |u| !(0..(u.length-1)).any? { |i| u[(i+1)..]&.any? { |k| !m[u[i]].include?(k)} } }.map{|u| u.sort {|a,b| a == b ? 0 : m[a].include?(b) ? -1 : 1 } }.map {|u| u[(u.length/2).to_i].to_i}.sum'
