require 'byebug'

class MaxIntSet
  def initialize(max)
    @max = max
    @set = Array.new(max) {false}
  end

  def insert(num)
    is_valid?(num)
    @set[num] = true
  end

  def remove(num)
    is_valid?(num)
    @set[num] = false
  end

  def include?(num)
    is_valid?(num)
    @set[num]
  end

  private

  def is_valid?(num)
    raise "Out of bounds" if num > @max || num < 0
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket_idx = num % @store.length
    @store[bucket_idx] << num
  end

  def remove(num)
    bucket_idx = num % @store.length
    @store[bucket_idx].delete(num)
  end

  def include?(num)
    bucket_idx = num % @store.length
    @store[bucket_idx].each{|el| return true if el == num}
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return nil if self.include?(num)
    bucket_idx = num % @store.length
    @store[bucket_idx] << num
    @count += 1
    resize! if @count == @store.length
  end

  def remove(num)
    bucket_idx = num % @store.length
    del = @store[bucket_idx].delete(num)
    @count -= 1 unless del == nil
  end

  def include?(num)
    bucket_idx = num % @store.length
    @store[bucket_idx].each{|el| return true if el == num}
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    @new_store = Array.new(2 * @count) { Array.new }
    @store.each do |bucket|
      bucket.each do |el|
        idx = el % @new_store.length
        @new_store[idx] << el
      end
    end
    @store = @new_store
  end
end
