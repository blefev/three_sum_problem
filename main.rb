require_relative 'threesums.rb'
require_relative 'tests.rb'
require 'benchmark'

def main



    %w(three_sum  three_sum_fast  three_sum_fastest).each do |three_sum_func|
      n = 100

      f = File.open("output/" + three_sum_func, 'w+')
      f.puts "n\tTime"
      puts "n\tTime"

      10.times.map do
        arr = gen_arr(n, -99999, 99999)

        n += 100

        bm = Benchmark.realtime do |b|
          send(three_sum_func, arr)
        end

        f.puts("#{n}\t#{bm}")
        puts("#{n}\t#{bm}")

      end

      f.close
    end

  puts "DONE!"
end

main