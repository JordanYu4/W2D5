class MaxIntSet
  
  def initialize(max)
    @max = max
    @set = Array.new(max) { false }
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @set[num] = true
  end

  def remove(num)
    raise "Out of bounds" unless is_valid?(num)
    @set[num] = false
  end

  def include?(num)
    @set[num] if is_valid?(num)
  end

  private
  
  attr_reader :max, :set

  def is_valid?(num)
    return num.between?(0, max) ? true : false
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket = self[num]
    bucket << num unless bucket.include?(num)
  end

  def remove(num)
    bucket = self[num]
    bucket.delete(num) if bucket.include?(num)
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
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
    resize! if count == num_buckets
    bucket = self[num]
    unless bucket.include?(num)
      bucket << num 
      @count += 1
    end
  end

  def remove(num)
    bucket = self[num]
    if bucket.include?(num)
      bucket.delete(num) 
      @count -= 1
    end
  end

  def include?(num)
    @store[num % num_buckets].include?(num)  
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_length = num_buckets * 2
    old = @store
    @store = Array.new(new_length) { [] }
    @count = 0
    old.each do |bucket|
      bucket.each do |el|
        self.insert(el)
      end
    end
  end
end
