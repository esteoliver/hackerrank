#!/bin/ruby
require 'benchmark'


#
# Complete the pseudoIsomorphicSubstrings function below.
#
def pseudoIsomorphicSubstrings(s)

  size = 0  # this show the current size of the set i
  sizes = []

  s_chars = s.chars

  dictionaries = []
  translations = []
  sets = []

  iter = 0

  k_to_check = 0
  s_chars.each_with_index do |c, index|

    dictionaries.push({ next: 0 }) # new dictionary for the last char
    translations.push([])          # new sequence that adds only the last char
    sets.unshift([])               # new set of sequences that has to be unique

    k = 0
    while k <= index

      if dictionaries[k][c].nil?
        dictionaries[k][c] = dictionaries[k][:next]
        dictionaries[k][:next] += 1
      end

      translations[k].push(dictionaries[k][c])

      if k < k_to_check
        sets[k].push(translations[k])
        size += 1
      elsif k == k_to_check
        iter += 1
        i = 0
        exists = true

        compare_with = sets[k].dup

        # puts "\n-------------------------"
        # puts translations[k]
        # puts "set: #{sets[k]}"
        while exists && !translations[k][i].nil? do
          compare_with.select! { |n| n[i] == translations[k][i] }
          exists &&= compare_with.length > 0
          i += 1
        end
        # puts "-------------------------\n"


        if !exists
          k_to_check = k + 1
          sets[k].push(translations[k])
          size += 1
        end
      end

      k += 1
    end

    sizes << size
  end

  # puts dictionaries
  # puts translations.map(&:join)
  # puts sets.map { |s| s.to_s }
  puts "checks: #{iter}"

  sizes
end


time = Benchmark.measure do
  fptr = File.open('result.txt', 'w')

  s = gets.to_s.rstrip
  
  result = pseudoIsomorphicSubstrings s

  fptr.write result.join "\n"
  fptr.write "\n"
  
  fptr.close()  
end

puts time