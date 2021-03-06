require 'benchmark'

def pseudoIsomorphicSubstrings(s)
  prefix_set_sizes = Array.new(s.length, 0)
  prefix_set_sizes[0] = 1
  tree = []
  start = 0
  iter = 0

  while (start < s.length) do

    check = true
    dictionary = {}
    dictionary_next_val = '0'

    status = [s[start], start, '', s[start+1..-1]]

    while !status.empty? do

      string, prefix_index, sequence, child = status

      if string.length == 1
        sequence << dictionary_next_val
        dictionary[string.to_sym] = dictionary_next_val
        dictionary_next_val = dictionary_next_val.next

        check = true

        if child.empty?
            break
        end

        status[0], status[1], status[2], status[3] = [string.concat(child[0]), prefix_index + 1, sequence, child[1..-1]]
        next
      end

      level = string.length - 1

      tree[level] = [] if tree[level].nil?

      translation = dictionary[string[-1].to_sym]

      if translation.nil?
        translation = dictionary_next_val
        dictionary[string[-1].to_sym] = dictionary_next_val
        dictionary_next_val = dictionary_next_val.next
      end

      sequence = sequence + translation

      if check
        iter += 1
        i = -1
        exists = true

        compare_with = tree[level].dup
        while (exists && !sequence[i].nil?) do
          compare_with.select! { |n| sequence[i] == n[i] }
          exists &&= compare_with.length > 0
          i -= 1
        end

        check = exists
      end

      if !check
        tree[level] << sequence
        prefix_set_sizes[prefix_index] += 1
      end

      if child.empty?
        break
      end

      status[0], status[1], status[2], status[3] = [string.concat(child[0]), prefix_index + 1, sequence, child[1..-1]]
    end
    start += 1

    break if check
  end

  puts "checks: #{iter}"

  prefix_set_sizes.inject([]) do |acc, n|
    acc << (acc.last || 0) + n
    acc
  end
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