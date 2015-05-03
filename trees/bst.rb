class Node
	attr_accessor :parent
	attr_accessor :left
	attr_accessor :right
	attr_accessor :value

	def initialize(value)
		@value = value
	end
end

class Tree
	attr_reader :root
	def initialize
		@root = nil
	end

	def build_tree(values)
		values.each do |val|
			node = Node.new(val)
			insert(node)
		end
	end

	def insert(node)
		if @root.nil?
			@root = node
		else
			insert_private(node, @root)
		end
	end

	def breadth_first_search(n)
		current_level = []
		current_level << @root
		while current_level.any?
			node = current_level.pop
			unless node.nil?
				if node.value == n
					return node
				end
				current_level << node.left
				current_level << node.right
			end
		end
		return nil
	end

	def depth_first_search(n)
		depth_first_search_private(n, @root)
	end

private

	def depth_first_search_private(n, node)
		if n == node.value
			return node
		end
		if n < node.value
			depth_first_search_private(n, node.left)
		elsif n > node.value
			depth_first_search_private(n, node.right)
		else
			return nil
		end
	end
	def insert_private(node, current)
		if current.nil?
			current = node
		else
			if node.value < current.value
				if current.left.nil?
					current.left = node
					node.parent = current
				else
					insert_private(node, current.left)
				end
			elsif node.value > current.value
				if current.right.nil?
					current.right = node
					node.parent = current
				else
					insert_private(node, current.right)
				end
			end
		end
	end
end


data = [80,47,100,83,14,8,1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = Tree.new
tree.build_tree(data)

node_23 = tree.depth_first_search(23)
node_8 = tree.breadth_first_search(8)

puts node_23.value unless node_23.nil?
puts node_8.value unless node_8.nil?
