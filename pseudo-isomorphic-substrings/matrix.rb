#!/bin/ruby

def to_sequence(s)
  dictionary = {}
  value = 0

  s.map do |char|
    if dictionary[char].nil?
      dictionary[char] = value
      value += 1
    end

    dictionary[char]
  end
end

#
# Complete the pseudoIsomorphicSubstrings function below.
#
def pseudoIsomorphicSubstrings(s)

  size = 1  # this show the current size of the set i
  graph = { 0 => {} } # representation of the set sequences
  sizes = []

  string_size = s.size
  matrix = []

  s_chars = s.chars
 
  s.size.times do |pi| # Si' : Prefix i
    matrix << []

    i = 0
    while i <= pi do
      matrix[pi] << s_chars[i..pi].join.ljust(string_size)
      i += 1
    end

    matrix[pi] = matrix[pi].join(' | ')
  end

  puts matrix

  sizes
end


fptr = File.open('result.txt', 'w')

s = gets.to_s.rstrip

result = pseudoIsomorphicSubstrings s

fptr.write result.join "\n"
fptr.write "\n"

fptr.close()
