#!/bin/bash

cat puzzle.in | rb -l 'slots=[]; chars.map(&:to_i).each_slice(2).with_index { |(f,s),i|  f.times { slots << i}; s&.times {slots << nil}; }; z = slots.index(nil); while slots.last.nil?; slots.pop; end;  while z < slots.length do; v = slots.pop; slots[z] = v; while z < slots.length && slots[z] != nil do; z += 1; end;  while slots.last.nil? do; slots.pop; end; end; slots.each.with_index.map { |a,b| a*b}.sum'
