#!/bin/bash

cat puzzle.in | rb 'map{ _1.chomp.split(/ +/).map(&:to_i) }.transpose.map(&:sort).transpose.map { (_1-_2).abs}.sum'
