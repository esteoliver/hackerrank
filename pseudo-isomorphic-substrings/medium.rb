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

  s_chars = s.chars
 
  s.size.times do |pi| # Si' : Prefix i
    if pi == 0
      sizes << size
      next 
    end

    substrings = [s_chars[0..pi]]

    while !substrings.empty? do
      sub = substrings.pop

      sequence = to_sequence(sub) # X

      # for every sequence, N-1 must exists and we only check if we can add the last bit
      pos = graph
      sequence[0..-2].each do |bit|
        pos = pos[bit]
      end
  
      next unless pos[sequence.last].nil?

      pos[sequence.last] = {}
      size += 1

      substrings << sub[1..-1] 
    end

    sizes << size
  end

  sizes
end


fptr = File.open('result.txt', 'w')

s = gets.to_s.rstrip

result = pseudoIsomorphicSubstrings s

fptr.write result.join "\n"
fptr.write "\n"

fptr.close()
