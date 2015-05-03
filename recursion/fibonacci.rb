def fibonacci(n)
	prev = 0;
	prev2 = 1;
	current = 0;
	n.times do
		current = prev + prev2
		prev2 = prev;
		prev = current;
		print current
		print " "
	end
	puts ""
end

def fib_rec(n)
	return (n==1 || n==0) ? n : fib_rec(n-1) + fib_rec(n-2)
end


#fibonacci(12)
#fibonacci(31)
puts fib_rec(5)
puts fib_rec(8)
puts fib_rec(12)