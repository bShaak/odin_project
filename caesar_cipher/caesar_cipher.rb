=begin
ascii capital letters 		65-90(decimal)
ascii lower case letters 	97-122
=end

def caesar_cipher(text, shift)
	if !shift.between?(0,25)
		puts "invalid shift"
		return ""
	end

	shifted_text = ""

	text.each_char do |j|

		tmp = j.ord
		#upper case ascii
		if tmp >= 65 && tmp <= 85
			tmp += shift

		#lower case ascii
		elsif tmp >= 97 && tmp <= 117
			tmp += shift

		#wrap around upper case			
		elsif tmp >= 86 && tmp <= 90
			tmp = 65 + tmp + shift - 90

		#wrap around lower case
		elsif tmp >= 118 && tmp <= 122
			tmp = 97 + tmp + shift - 122
		end

		shifted_text += tmp.chr
	end

	#puts shifted_text
	return shifted_text
end

txt = caesar_cipher("all lower case", 3)
puts txt
txt = caesar_cipher("Some UppEr", 5)
puts txt
txt = caesar_cipher("Shift too big", 27)
puts txt