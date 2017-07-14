require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return nil if include?(key)
    @count += 1
    resize! if @count == num_buckets
    hash = key.hash
    bucket_idx = hash % num_buckets
    @store[bucket_idx] << key

  end

  def include?(key)
    hash = key.hash
    bucket_idx = hash % num_buckets
    @store.each do |bucket|
      bucket.each do |el|
        return true if el == key
      end
    end
    false
  end

  def remove(key)
    hash = key.hash
    bucket_idx = hash % num_buckets
    del = @store[bucket_idx].delete(key)
    @count -= 1 unless del == nil
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`

  end

  def num_buckets
    @store.length
  end

  def resize!
  end
end
