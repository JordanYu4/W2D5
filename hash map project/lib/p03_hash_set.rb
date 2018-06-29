class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count == num_buckets
    bucket = self[key]
    unless bucket.include?(key)
      bucket << key 
      @count += 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    bucket = self[key]
    if bucket.include?(key)
      bucket.delete(key) 
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
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
