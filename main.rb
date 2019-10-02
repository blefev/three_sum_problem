require_relative 'threesums.rb'
require_relative 'tests.rb'
require 'benchmark'

def main
  %w(three_sum  three_sum_fast  three_sum_fastest).each do |three_sum_func|
    # n = nil
    # increment = nil
    # trials = nil
    n = 8
    increment = 2
    trials = 8

=begin
    if three_sum_func == 'three_sum'
      n = 1
      increment = 1
      trials = 300
    elsif three_sum_func == 'three_sum_fast'
      n = 100
      increment = 10
      trials = 300
    elsif three_sum_func == 'three_sum_fastest'
      n = 100
      increment = 100
      trials = 100
    end
=end

    f = File.open("output/" + three_sum_func, 'w+')
    #f.puts "n\tTime"
    puts "n\tTime"

    prev = 0
    trials.times.map do
      arr = gen_arr(n, -99999, 99999)
      #n += increment

      bm = Benchmark.realtime do |b|
        send(three_sum_func, arr)
      end

      if prev != 0
        dbl_ratio = bm / prev;
      end
      prev = bm

      f.puts("#{n}\t#{bm}")
      puts("#{n},\t#{bm},\t#{dbl_ratio}")
      n *= increment
    end

    f.close
  end

  puts "DONE!"
end

main