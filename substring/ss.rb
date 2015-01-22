=begin
substring function
input is a string and a dictionary of strings
out put is a hash that contains the substrings contained in first string and count
=end

def substrings(text, string_dict)
	if text.nil? || string_dict.nil?
		return nil
	end

	text_tmp = text.downcase

	substring_hash = Hash.new
	#get all matches in text and add to hash
	string_dict.each do |s|
		if substring_hash[s].nil?
			arr = text_tmp.scan(s.downcase)
			cnt = arr.length
			if cnt > 0
				substring_hash[s] = cnt
			end
		end
	end

	return substring_hash
end


dict = ["hello", "down", "Friend", "big"]
puts substrings("hello friend", dict)

puts substrings("hello hunger Down", dict)