#!/usr/bin/ruby
# -*- coding: utf-8 -*-

AlphaSize = (1 << 8)

class ShiftAnd
  def initialize(pattern, text)
    @P = pattern
    @M = @P.size
    @T = text
    @N = @T.size
  end

  # Preprocessing
  def preprocess()
    # Build bitmask I
    @I = 1 << (@M-1);
    # Build bitmask B
    @B = Array.new(AlphaSize) { 0 }
    (0...@M).each do |j|
      @B[@P[j]] |= 1 << j
    end
  end

  # Searching
  def search()
    mskS = 0
    (0...@N).each do |i|
      mskS = ((mskS << 1) | 1) & @B[@T[i]];
      return i-@M+1 if (mskS & @I) != 0
    end
    return -1
  end
end

if ARGV.size != 2
  $stderr.puts "The number of arguments is invalid.\n" + 
               "Usage: ruby #{$0} Pattern Text\n"
  exit
end

P = ARGV.shift
T = ARGV.shift
PM = ShiftAnd.new(P, T)
PM.preprocess()
puts PM.search()
