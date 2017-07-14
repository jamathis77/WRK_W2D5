require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @first = nil
    @last = nil
    @count = 0
  end

  def [](i)
    links = []
    link = @first
    while link.next != nil
      links << link
      link = link.next
    end
    links << link
    links[i]

    # links.each_with_index { |link, j| return link if i == j }
    # nil
  end

  def first
    @first
  end

  def last
    @last
  end

  def empty?
    return true if @count < 1
    return false
  end

  def get(key)
    return nil if @count == 0
    link = @first
    return link.val if link.key == key
    while link.next != nil
      link = link.next
      return link.val if link.key == key
    end
    nil
  end

  def include?(key)
    return false if @count == 0
    result = get(key)
    return false if result == nil
    true
  end

  def append(key, val)
    new_link = Link.new(key, val)
    if @first == nil
      @first = new_link
      @last = new_link
    else
      @last.next = new_link
      new_link.prev = @last
      @last = new_link
    end
    @count += 1
  end

  def update(key, val)
    return nil if @count == 0
    link = @first

    if link.key == key
      link.val = val
      return nil
    end

    while link.next != nil
      link = link.next
      if link.key == key
        link.val = val
        return nil
      end
    end

    nil
  end

  def remove(key)
    return nil if @count == 0
    link = @first

    kill(link) if link.key == key
    while link.next != nil
      link = link.next
      kill(link) if link.key == key
    end
    @count -= 1
    nil
  end

  def kill(link)
    if @first == link
      @first = link.next
    end

    if @last == link
      @last = link.prev
    end
    link.prev.next = link.next unless link.prev == nil
    link.next.prev = link.prev unless link.next == nil
  end

  def each(&prc)
    return nil if @count == 0
    link = @first
    flag = true
    while flag
      prc.call(link)
      if link.next == nil
        flag = false
      end
      link = link.next
    end

    nil
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
