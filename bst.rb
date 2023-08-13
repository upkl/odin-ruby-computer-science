class Node
    include Comparable

    def initialize data
        @data = data
        @left = nil
        @right = nil
    end

    def data
        @data
    end
    
    def data= data
        @data = data
    end

    def left= node
        @left = node
    end

    def left
        @left
    end

    def right= node
        @right = node
    end

    def right
        @right
    end

    def <=> other
        @data <=> other.data
    end
end

class Tree
    def initialize data_array
        @root = nil
        build_tree data_array
        @root
    end

    def root
        @root
    end

    def build_tree data_array
        data_array = Tree.pre_order_data(data_array.sort.uniq)
        data_array.each { |d| insert d }
    end

    def insert data, node=@root
        if @root.nil?
            @root = Node.new data
        else
            if data < node.data
                if node.left
                    insert data, node.left
                else
                    node.left = Node.new data
                end
            else
                if node.right
                    insert data, node.right                
                else
                    node.right = Node.new data         
                end
            end
        end
    end

    def delete data
        @root = delete_helper data, @root
    end

    def find data, node=@root
        return nil if node.nil?
        return node if node.data == data

        if data < node.data
            find data, node.left
        else
            find data, node.right
        end
    end

    def level_order &block
        if @root.nil?
            if block_given?
                return nil 
            else
                return []
            end
        end
            
        queue = [@root]
        result = []

        until queue.empty?
            node = queue.shift
            if block_given?
                yield node
            else
                result.append(node.data)
            end
            queue.append(node.left) unless node.left.nil?
            queue.append(node.right) unless node.right.nil?
        end

        return result unless block_given?
    end

    def inorder node=@root, &block
        if node.nil?
            if block_given?
                return nil 
            else
                return []
            end
        end

        if not block_given?
            result = []
            result += inorder node.left
            result.append(node.data)
            result += inorder node.right
            result
        else
            inorder node.left, &block
            yield node
            inorder node.right, &block
        end
    end

    def preorder node=@root, &block
        if node.nil?
            if block_given?
                return nil 
            else
                return []
            end
        end

        if not block_given?
            result = []
            result.append(node.data)
            result += preorder node.left
            result += preorder node.right
            result
        else
            yield node
            preorder node.left, &block
            preorder node.right, &block
        end
    end

    def postorder node=@root, &block
        if node.nil?
            if block_given?
                return nil 
            else
                return []
            end
        end

        if not block_given?
            result = []
            result += postorder node.left
            result += postorder node.right
            result.append(node.data)
            result
        else
            postorder node.left, &block
            postorder node.right, &block
            yield node
        end
    end

    def height node=@root
        return 0 if node.nil?
        return 1 + [height(node.left), height(node.right)].max
    end

    def depth node, start=@root
        return nil if node.nil?
        return 0 if node == start

        if node.data < start.data
            r = depth node, start.left
        else
            r = depth node, start.right
        end

        return nil if r.nil?
        1 + r
    end

    def balanced? node=@root
        return true if node.nil?
        return false if (height(node.left) - height(node.right)).abs > 1
        balanced?(node.left) and balanced?(node.right)
    end

    def rebalance
        data = inorder
        @root = nil
        build_tree(data)
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end

    private
    def self.pre_order_data data_array
        return [] if data_array.nil? or data_array.length == 0
        m = data_array.length / 2
        return [data_array[m]] + pre_order_data(data_array[...m]) + pre_order_data(data_array[m+1...])
    end

    def delete_helper data, node
        return nil if node.nil?
        if data < node.data
            node.left = delete_helper data, node.left
        elsif node.data < data
            node.right = delete_helper data, node.right
        else
            return node.right if node.left.nil?
            return node.left if node.right.nil?

            if height(node.left) < height(node.right)
                minright = find_min(node.right)
                node.data = minright
                node.right = delete_helper minright, node.right
            else
                maxleft = find_max(node.left)
                node.data = maxleft
                node.left = delete_helper maxleft, node.left
            end
        end
        node
    end

    def find_min node
        return node.data if node.left.nil?
        find_min node.left
    end

    def find_max node
        return node.data if node.right.nil?
        find_max node.right
    end
end

puts "1. Create tree"
t = Tree.new(Array.new(15) { rand(1..100) })
t.pretty_print

puts "2. Is it balanced?"
puts t.balanced?

puts "3. Print"
t.level_order {|x| print "<#{x.data}>"}
puts t.inorder
puts t.preorder
puts t.postorder

puts "4. Unbalance by adding numbers > 100"
(1..10).each { t. insert(rand(101..200))}
t.pretty_print

puts "5. Is it balanced?"
puts t.balanced?

puts "6. Rebalance"
t.rebalance
t.pretty_print

puts "7. Is it balanced?"
puts t.balanced?

puts "8. Print"
t.level_order {|x| print "<#{x.data}>"}
puts t.inorder
puts t.preorder
puts t.postorder
