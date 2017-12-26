require 'benchmark'

class Hash
  def sort(method, predicat = 'key')
    if predicat == 'key'
      sorted = send("#{method}", self.keys)
      sorted_hash = self.sort_by { |key, value| sorted.index(key) }

    else
      sorted = send("#{method}", self.values)
      sorted_hash = self.sort_by { |key, value| sorted.index(value) }
    end

    sorted_hash.to_h
  end
end

def swap(array, i, j)
  buf = array[i]
  array[i] = array[j]
  array[j] = buf
end

def bubble_sort(array)
  len = (array.size) - 1

  (0...len).each  { |i| (len).downto(1+i).each { |j| swap(array, j, j-1) if array[j-1] > array[j] } }
  array
end

def quicksort(array)
  return array if array.size <= 1

  pivot = array.delete_at((array.size)/2)
  left = []
  right = []

  array.each do |i|
    if i >= pivot
      right << i
    else

      left << i
    end
  end

  quicksort(left) + [ pivot ] + quicksort(right)
end

def shell_sort(array)
  len = array.size - 1
  d = len/2

  while d >= 1
    len.downto(0) do |i|
      0.upto(i-d) do |j|
        swap(array, j, j+d) if array[j] > array[j+d]
      end
    end
    d /= 2
  end
  array
end

hash = { me: 18, mom: 42, brother: 20, dad: 45,  grandmother: 55 ,child: 10 }

Benchmark.bmbm do |x|
  x.report("bubble sort by keys") { hash.sort(:bubble_sort, 'key') }
  x.report("bubble sort by values") { hash.sort(:bubble_sort, 'values') }
  x.report("quicksort by keys") { hash.sort(:quicksort, 'key') }
  x.report("quicksort by values") { hash.sort(:quicksort, 'values') }
  x.report("shell sort by keys") { hash.sort(:shell_sort, 'key') }
  x.report("shell sort by values") { hash.sort(:shell_sort, 'values') }
end
