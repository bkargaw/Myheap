require_relative "heap"

class Array
  def heap_sort!
    heap = BinaryMinHeap.new
    each { |el| heap.push(el) }
    i = 0
    while heap.count > 0
      self[i] = heap.extract
      i += 1
    end

  end
end
