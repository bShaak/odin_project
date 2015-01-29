def bubble_sort(a)
	n = a.size
	tmp = 0
	done = false
	while !done
		done = true
		i = 1
		while i < n
			if (a[i] < a[i-1])
				tmp = a[i]
				a[i] = a[i-1]
				a[i-1] = tmp
				done = false
			end
			i += 1
		end
		n-=1
	end
	return a
end

def bubble_sort_block(a, &compare)
	n = a.size
	done = false
	while !done
		done = true
		i = 1
		while i < n
			if (compare.call(a[i], a[i-1]))
				tmp = a[i]
				a[i] = a[i-1]
				a[i-1] = tmp
				done = false
			end
			i += 1
		end
		n-=1
	end
	return a
end

arr_to_sort = [3,2,6,7,1]
puts bubble_sort (arr_to_sort)

puts bubble_sort_block(["hi", "hey", "hello"]) {|a,b| a.length - b.length < 0}


