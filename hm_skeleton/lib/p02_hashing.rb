
class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    str = self.join
    fixnum_chars = []
    str.chars.each_with_index do |char, idx|
      fixnum_chars << char
      fixnum_chars << idx
    end
    fixnum_chars.join.to_i
  end
end

class String
  def hash
    ords = []
    self.chars.each do |char|
      ords << char.ord
    end
    ords.join.to_i
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    fin = []
    sorted_keys = self.keys.sort
    sorted_keys.each do |k|
      fin << self[k]
    end
    fin.hash + self.length
  end
end
