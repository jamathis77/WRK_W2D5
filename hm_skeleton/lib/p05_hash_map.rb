require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    hash = key.hash
    bucket_idx = hash % num_buckets
    @store.each do |bucket|
      var = bucket.include?(key)
      return true if var == !nil
    end
    false
  end

  def set(key, val)
    if include?(key)
      hash = key.hash
      bucket_idx = hash % num_buckets
      @store[bucket_idx].update(key, val)
    else
      @count += 1
      resize! if @count == num_buckets
      hash = key.hash
      bucket_idx = hash % num_buckets
      @store[bucket_idx].append(key, val)
    end


  end

  def get(key)
    return nil unless include?(key)
    hash = key.hash
    bucket_idx = hash % num_buckets
    @store[bucket_idx].get(key)
  end

  def delete(key)
    return nil unless include?(key)
    hash = key.hash
    bucket_idx = hash % num_buckets
    @count -= 1
    @store[bucket_idx].remove(key)


  end

  def each(&prc)
    @store.each do |bucket| #bucket is a linkedlist (room in house)
      bucket.each{|link| prc.call(link.key, link.val)}
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    #current_store is OLD DATA
    current_store = @store
    #make space (bigger house for anticipated bigger family of elements)
    new_store = Array.new(@store.length * 2) {LinkedList.new}
    #go through all the old family members and distribute them into new
    @store.each do |bucket| #bucket is a linkedlist (room in house)
      bucket.each do |el| #el is a link (single family member)
        hash = el.key.hash #special code to find new room
        bucket_idx = hash % new_store.length #room # of new room
        new_store[bucket_idx].append(el.key, el.val) #add him to new room
      end
    end
    @store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
