

class Node
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
    prev.next = self.next
    self.next.prev = prev
    self.next = nil
    prev = nil
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next, @tail.prev = @tail, @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    return true if first == tail
    false
  end

  def get(key)
    node = find_key(key)
    return node.val unless node.nil?
    nil
  end

  def include?(key)
    return true if find_key(key)
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    last.next, new_node.prev = new_node, last
    new_node.next, tail.prev = tail, new_node
  end

  def update(key, val)
    node = find_key(key)
    node.val = val unless node.nil?
    nil
  end

  def remove(key)
    node = find_key(key)
    node.remove unless node.nil? 
    
  end

  def each(&block)
    current_node = first
    until current_node == tail
      block.call(current_node)
      current_node = current_node.next
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
  
  private 
  
  def find_key(key)
    current_node = first
    until current_node == tail
      if current_node.key == key
        return current_node
      end
      current_node = current_node.next
    end
    nil
  end
  
  attr_reader :head, :tail
  
end
