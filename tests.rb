MAX = 10
require_relative 'threesums.rb'


def test_threesum
  %w(three_sum  three_sum_fast  three_sum_fastest).each do |three_sum_func|
    10.times do
      arr = Array.new(MAX, 10000)

      used_indices = []

      # randomly assign array values to triplets which sum to zero
      n1 = rand(0..100)
      n2 = rand(-99..(-1 * n1))
      n3 = 0 - (n1 + n2)

      xs = [n1, n2, n3]


      xs.each do |x|
        index = nil

        loop do
          index = rand(0..MAX - 1)
          break unless used_indices.include?(index)
        end

        used_indices << index
        arr[index] = x
      end


      puts "================"
      puts "Testing #{three_sum_func}"

      p arr

      result = send(three_sum_func, arr)
      if result != 1
        puts "Threesum failed!"
        puts "Expected: 1, got #{result} instead"
      else
        puts "Threesum iteration passed.."
      end
      puts ""
    end
  end
end

test_threesum
