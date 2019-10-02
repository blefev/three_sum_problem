require 'set'

# naive three_sum
# loop through each element and
# see if any trio sum to zero,
# returning the count of such
# occurrences
def three_sum(arr)
  count = 0

  # loop through each array
  (0..arr.length-3).each { |i|
    (i+1..arr.length-2).each { |j|
      (i+2..arr.length-1).each { |k|
      # check if the three elements sum to 0
      if (arr[i]+arr[j]+arr[k] == 0)
        count += 1
      end
      }
    }
  }
  count
end

# three_sum_fast sorts the input array
# and then for every pair of digits,
# does a binary search for its complement,
# or -arr[i] - arr[j] - as this number
# will sum to 0. It skips results of the
# search that are greater than j because
# it has already looped over those elements
def three_sum_fast(arr)
  arr = merge_sort(arr)
  count = 0

  (0..arr.length-1).each { |i|
    (i+1..arr.length-1).each { |j|
      if bin_search(arr, -arr[i] - arr[j]) > j
        count += 1
      end
    }
  }
  count
end

# three_sum_fastest is similar to
# three_sum_fast, but instead of
# using binary searching, it takes advantage
# of a set and its built in hashing.
# Hashing is much faster than even a binary
# search - so whenever we try to find
# the complement of arr[i] + arr[j],
# we just have to look in the set.
# When the check is over, we put arr[j]
# into the set for future searching
#
# This is a dynamic programming method,
# where we use a form of memoization
# in order to only do certain operations
# once and storing the result. In this case
# we search for arr[j] a single time and store
# it in the set for extremely quick access.
#
# I was able to come up with this method
# because I've read several code interview
# problems, and dynamic programming comes up
# as the fastest solution very frequently.
def three_sum_fastest(arr)
  arr = merge_sort(arr)
  count = 0

  (0..arr.length-2).each { |i|
    set = Set.new

    (i+1..arr.length-1).each { |j|
      if set.include?(-arr[i]-arr[j])
        count += 1
      end

      set.add(arr[j])
    }
  }
  count
end

# General binary search,
# as explained by the textbook.
def bin_search(arr, key)
  low = 0
  high = arr.length - 1
  while high >= low do
    mid = low  + (high - low) / 2
    if arr[mid] > key
      high = mid - 1
    elsif arr[mid] < key
      low = mid + 1
    else
      return mid
    end
  end
  return 0
end

# General merge sort as
# described by the textbook.
def merge_sort(arr)
  # don't sort an array with length = 1
  if arr.length < 2
    return arr
  end

  # grab the middle point
  ind = arr.length / 2
  # recursively call merge_sort
  a1, a2 = merge_sort(arr[0...ind]), merge_sort(arr[ind..-1])

  n_arr = []

  # sort the sub arrays
  while[a1,a2].none? {|a| a.empty? } do
    if a1[0] < a2[0]
      n_arr << a1.shift
    else
      n_arr << a2.shift
    end
  end

  n_arr + a1 + a2
end

# generate an array with random ints
def gen_arr(n, min = 0, max = 999999999)
  n.times.map do |x|
    rand(min..max)
  end
end
