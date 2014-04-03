=begin
stock_picker chooses the optimum days to buy and sell a stock
given an array of stock prices
=end
def stock_picker(sp)
	i = 0
	profit = 0
	buy = -1
	sell = -1
	sp.each do |a|
		j = 0
		sp.each do |b|
			if j > i
				tmp = b-a
				if tmp > 0 && tmp > profit
					profit = tmp
					buy = i
					sell = j
				end
			end
			j += 1
		end
		i += 1
	end
	return [buy,sell]
end

puts stock_picker([4,3,2,7,8]) # a normal case
puts stock_picker ([2,3,4,1]) # with minimum at the end
puts stock_picker([10,2,3,4,5,1]) # max at beginning and min at end
puts stock_picker([5,4,3,2,1]) # decreasing stock price should not be bought
