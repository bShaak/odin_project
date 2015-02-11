class AllVowels
	include Enumerable

	@@vowels = %w{a e i o u}
	def each
		@@vowels.each{|v| yield v}
	end
end

class Song
	include Comparable

	attr_accessor :length
	def initialize(song_name, length)
		@song_name = song_name
		@length = length
	end

	def <=>(other)
		@length <=> other.length
	end
end

a = Song.new('Rock around the clock', 143)
b = Song.new('Bohemian Rhapsody', 544)
c = Song.new("Minute Waltz", 60)

p a < b
p b >= c
p c > a
p a.between?(c,b)

x = AllVowels.new

p x.collect{|i| i + "x"}
p x.detect{|i| i > "j"}
p x.sort
p x.max