=begin
ascii capital letters 		65-90(decimal)
ascii lower case letters 	97-122
=end
@lower_min = 97
@lower_max = 122
@upper_min = 65
@upper_max = 90

def caesar_cipher(text, shift)
	if !shift.between?(0,25)
		puts "invalid shift"
		return ""
	end

	shifted_text = ""

	text.each_char do |j|

		tmp = j.ord
		#upper case ascii
		if tmp >= @upper_min && tmp <= (@upper_max - shift)
			tmp += shift

		#lower case ascii
		elsif tmp >= @lower_min && tmp <= (@lower_max - shift)
			tmp += shift

		#wrap around upper case			
		elsif tmp >= (@upper_max - (shift-1)) && tmp <= @upper_max
			tmp = tmp + upper_min + shift - @upper_max

		#wrap around lower case
		elsif tmp >= (@lower_max - (shift-1)) && tmp <= @lower_max
			tmp = tmp + @upper_min + shift - @upper_max
		end

		shifted_text += tmp.chr
	end

	return shifted_text
end

txt = caesar_cipher("all lower case", 3)
puts txt
txt = caesar_cipher("Some UppErz", 5)
puts txt
txt = caesar_cipher("Shift too big", 27)
puts txt