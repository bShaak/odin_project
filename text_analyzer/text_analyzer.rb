#analyze read in text from file

#assign filename
filename = ARGV[0]
filename ||= "oliver.txt"

stopwords = %w{the a by on for of are with just but and to the my I has some in}

lines = File.readlines(filename)
line_count = lines.size
text = lines.join
total_characters = text.length
total_chars_no_spaces = text.gsub(/\s+/, '').length
words = text.split
word_count = words.length
sentences = text.gsub(/\s+/, ' ').strip.split(/\.|\?|!/)
sentence_count = sentences.length
paragraph_count = text.split(/\n\n/).length

keywords = words.select {|word| !stopwords.include?(word)}
keyword_percentage = ((keywords.length.to_f / word_count.to_f)*100).to_i

#collect mid length sentences containing 'is' and 'are'
#these sentences typically contain nouns and therefore may be interesting

sentences_sorted = sentences.sort_by{|sentence| sentence.length}
one_third = sentences_sorted.length / 3
puts one_third
ideal_sentences = sentences_sorted.slice(one_third, one_third + 1)
ideal_sentences = ideal_sentences.select{|sentence| sentence =~ /is|are|am/}

puts "#{line_count} lines"
puts "#{total_characters} total characters"
puts "#{total_chars_no_spaces} total characters exluding whitespace"
puts "#{word_count} words"
puts "#{sentence_count} sentences"
puts "#{paragraph_count} paragraphs"
puts "#{word_count / sentence_count} words per sentence"
puts "#{sentence_count / paragraph_count} sentences per paragraph"
puts "#{keyword_percentage}% percentage of non-fluff words"
puts "\n\n Possibly interesting sentences:\n\n"
puts ideal_sentences.join(". ")