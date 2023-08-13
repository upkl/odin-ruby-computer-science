# frozen_string_literal: true

# A node for my LinkedList
class Node
  attr_reader :value, :head
  attr_accessor :next_node

  def initialize(value = nil)
    @value = value
    @next_node = nil
  end
end

# A linked list
class LinkedList
  def initialize
    @head = nil
  end

  def append(value)
    n = Node.new(value)
    if @head.nil?
      @head = n
    else
      t = tail
      t.next_node = n
    end
  end

  def prepend(value)
    n = Node.new(value)
    n.next_node = @head
    @head = n
  end

  def size
    return 0 if @head.nil?

    s = 1
    n = @head
    until n.next_node.nil?
      s += 1
      n = n.next_node
    end
    s
  end

  def tail
    if @head.nil?
      nil
    else
      n = head
      n = n.next_node until n.next_node.nil?
    end
  end

  def at(index)
    return nil if @head.nil?

    n = @head
    (0...index).each do
      return nil if n.next_node.nil?

      n = n.next_node
    end
    n.value
  end

  def pop
    if @head.nil?
      nil
    elsif @head.next_node.nil?
      value = @head.value
      @head = nil
      value
    else
      n = head
      n = n.next_node until n.next_node.next_node.nil?
      value = n.next_node.value
      n.next_node = nil
      value
    end
  end

  def contains?(value)
    unless @head.nil?
      return true if @head.value == value

      n = @head
      until n.next_node.nil?
        n = n.next_node
        return true if n.value == value
      end
    end
    false
  end

  def find(value)
    unless @head.nil?
      return 0 if @head.value == value

      n = @head
      i = 0
      until n.next_node.nil?
        n = n.next_node
        i += 1
        return i if n.value == value
      end
    end
    nil
  end

  def to_s
    values = []
    n = @head
    loop do
      return (values + ['nil']).join(' -> ') if n.nil?

      values << "( #{n.value} )"
      n = n.next_node
    end
  end
end
