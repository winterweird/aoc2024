#!/bin/bash

cat puzzle.in | rb  $(cat 2.rb) | rb 'map(&:to_i).sum'
