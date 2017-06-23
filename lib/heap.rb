class BinaryMinHeap
  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
    @store.length
  end

  def extract
    BinaryMinHeap.switch(@store, 0, count - 1)
    val = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, &prc)

    val
  end

  def peek
    @store.first
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, count - 1, &prc) unless count == 1
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    left = parent_index * 2 + 1
    right = parent_index * 2 + 2
    left = left >= len ? nil : left
    right = right >= len ? nil : right
    if right
      return [left, right]
    elsif left
      return [left]
    end

    nil
  end

  def self.parent_index(child_index)
    raise('root has no parent') if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    left, right = BinaryMinHeap.child_indices(len, parent_idx)

    if right
      if prc.call(array[right], array[left]) == -1 &&
         prc.call(array[right], array[parent_idx]) == -1
        BinaryMinHeap.switch(array, right, parent_idx)
        BinaryMinHeap.heapify_down(array, right, &prc)
      elsif prc.call(array[left], array[parent_idx]) == -1
        BinaryMinHeap.switch(array, left, parent_idx)
        BinaryMinHeap.heapify_down(array, left, &prc)
      end
    elsif left && prc.call(array[left], array[parent_idx]) == -1
      BinaryMinHeap.switch(array, left, parent_idx)
      BinaryMinHeap.heapify_down(array, left, &prc)
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    parent_idx = BinaryMinHeap.parent_index(child_idx)
    if prc.call(array[child_idx], array[parent_idx]) == -1
      BinaryMinHeap.switch(array, child_idx, parent_idx)
      BinaryMinHeap.heapify_up(array, parent_idx, &prc) unless parent_idx == 0
    end

    array
  end

  private

  def self.switch(arr, i, j)
    arr[j], arr[i] = arr[i], arr[j]
  end
end
