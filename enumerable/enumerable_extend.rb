module Enumerable
	def my_each
		return self unless block_given?
		for i in self
			yield(i)
		end
	end

	def my_each_with_index
		return self unless block_given?
		x = 0
		for i in self
			yield(i, x)
			x += 1
		end
	end

	def my_select
		return self unless block_given?
		a = []
		for i in self
			a.push(i) if yield(i)
		end
		return a
	end

	def my_all?
		return false unless block_given?
		for i in self
			return false unless yield(i)
		end
		return true
	end

	def my_any?
		return false unless block_given?
		for i in self
			return true if yield(i)
		end
		return false
	end

	def my_none?
		return false unless block_given?
		for i in self
			return false if yield(i)
		end
		return true
	end

	def my_count
		j = 0
		if block_given?
			for i in self
				if yield(i)
					j += 1
				end
			end
		else
			for i in self
				j += 1
			end
		end
		return j
	end

	def my_map
		return self unless block_given?
		for i in self
			a.push(yield(i))
		end
	end

	def my_inject(num = nil)
		accumulator = num.nil? ? first : num
		my_each { |i| accumulator = yield(accumulator, i)}
		accumulator
	end
end

def multiply_els(list)
	list.my_inject(1) {|product, i| product * i}
end

puts multiply_els([1,3,5,6])