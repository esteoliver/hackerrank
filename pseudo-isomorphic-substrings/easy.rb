#!/bin/ruby
require 'set'

def to_sequence(s)
  dictionary = {}
  value = 0

  s.chars.map do |char|
    if dictionary[char].nil?
      dictionary[char] = value
      value += 1
    end

    dictionary[char]
  end.join
end

#
# Complete the pseudoIsomorphicSubstrings function below.
#
def pseudoIsomorphicSubstrings(s)
  
  # Generate prefixs S'
  prefixs = []
  (s.size).times.each do |i|
    prefixs << s[0..i]
  end
  puts prefixs

  # For every i,j where i < j, the substrings of Si' (Sbi), are a subset of Sbj
  # and Sbj - Sbi are the substring that includes the last char of Sj'
  subsets = prefixs.map do |prefix|
    s = []

    (prefix.size).times.each do |i|
      s << prefix[i..-1]
    end
    
    s
  end
  puts subsets

  # Transform the substring to a sequence of numbers to compare values
  subsets.each do |subs|
    subs.map! { |sub| to_sequence(sub) }
  end
  puts subsets

  # For every i,j, such that 0 <= i < j, and a function ISO that generate
  # a set such that no two strings inside S' are pseudo-isomorphic to each other,
  # SUM(ISO(Si')) < ISO(Sj')
  puts "="*50
  isosets = []
  subsets.each_with_index do |subs, i|
    if i == 0
      isosets << Set.new(subs)
      next
    end

    isosets << Set.new(subs).merge(isosets[i - 1])
  end
  puts isosets

  # Get sizes
  isosets.map { |iso| iso.size }    
end


fptr = File.open('result.txt', 'w')

s = gets.to_s.rstrip

result = pseudoIsomorphicSubstrings s

fptr.write result.join "\n"
fptr.write "\n"

fptr.close()
