class Node
  def initialize(value=nil)
    @value = value
    @next_node = nil
  end

  def value
    @value
  end

  def next_node=(n)
    @next_node = n
  end

  def next_node
    @next_node
  end
end

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
    if @head.nil?
      @head = n
    else
      n.next_node = @head
      @head = n
    end
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

  def head
    @head
  end

  def tail
    if @head.nil?
      nil
    else
      n = head
      until n.next_node.nil?
        n = n.next_node
      end
      n
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
      until n.next_node.next_node.nil?
        n = n.next_node
      end
      value = n.next_node.value
      n.next_node = nil
      value
    end
  end

  def contains?(value)
    if @head.nil?
      false
    else
      return true if @head.value == value
      n = @head
      until n.next_node.nil?
        n = n.next_node
        return true if n.value == value
      end
      false
    end
  end

  def find(value)
    if @head.nil?
      nil
    else
      return 0 if @head.value == value
      n = @head
      i = 0
      until n.next_node.nil?
        n = n.next_node
        i += 1
        return i if n.value == value
      end
      nil
    end
  end

  def to_s
    values = []
    n = @head
    loop do
      if n.nil?
        return (values + ["nil"]).join(" -> ")
      else
        values << "( #{n.value} )"
        n = n.next_node
      end
    end
  end
end
      
