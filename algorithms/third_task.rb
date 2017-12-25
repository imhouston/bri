class Hash
  def sort(method, predicat = 'key')
    if predicat == 'key'
      sorted = send("#{method}", self.keys)
      sorted_hash = self.sort_by { |key, value| sorted.index(key) }

    else
      sorted = send("#{method}", self.values)
      sorted_hash = self.sort_by { |key, value| sorted.index(value) }
    end

    sorted_hash
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
  len = array.size
  m = len / 2

end



hash = { mom: 42, brother: 20, dad: 45,  child: 10 }


