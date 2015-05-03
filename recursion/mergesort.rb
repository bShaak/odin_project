def merge_sort(arr, left, right, arr2)
	return if(right - left < 2)

	middle = left + (right-left)/2
	merge_sort(arr, left, middle, arr2)
	merge_sort(arr, middle, right, arr2)
	merge(arr, left, right, arr2)
end

def merge(arr, left, right, arr2)
	middle = left + (right-left)/2
	i0 = left
	i1 = middle
	puts left
	puts right
	puts middle
	for j in left..right do
		if(i0 < middle && (i1 >= right || arr[i0] <= arr[i1]))
			arr2[j] = arr[i0]
			i0 = i0 + 1
		else
			arr2[j] = arr[i1]
			i1 = i1 + 1
		end
	end
end



data = [4,3,5,18]
data2= [0,0,0,0]

merge_sort(data, 0, 3, data2)

puts data2