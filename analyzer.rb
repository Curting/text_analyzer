# analyzer.rb -- Text Analyzer

stop_words = %w{the a by on for of are with just but and to the my I has some in}
lines = File.readlines(ARGV.first)
lines_count = lines.size
text = lines.join

# Count the characters
total_characters = text.length
total_characters_nospaces = text.gsub(/\s+/, '').length

# Count the words, sentences, and paragraphs
word_count = text.split.length
sentence_count = text.split(/\.|\?|!/).length
paragraph_count = text.split(/\n\n/).length

# Find the percentage of keywords (non stop words) against all words
words = text.scan(/\w+/)
key_words = words.select { |word| !stop_words.include?(word) }
key_words_density = ((key_words.length.to_f / words.length.to_f) * 100).to_i

# Summarize the text by picking some choice sentences
sentences = text.gsub(/\s+/, ' ').strip.split(/\.|\?|\!/)
sentences_sorted = sentences.sort_by { |sentence| sentence.length }
one_third = sentences_sorted.length / 3
ideal_sentences = sentences_sorted.slice(one_third, one_third + 1)
ideal_sentences = ideal_sentences.select { |sentence| sentence =~ /is|are/ }

# Give the analysis back to the user
puts "#{lines_count} lines"
puts "#{total_characters} characters"
puts "#{total_characters_nospaces} characters (excluding spaces)"
puts "#{word_count} words"
puts "#{sentence_count} sentences"
puts "#{paragraph_count} paragraphs"
puts "#{sentence_count / paragraph_count} sentences per paragraph (average)"
puts "#{word_count / sentence_count} words per sentence (average)"
puts "#{key_words_density}% are non-fluff words"
puts "\nSummary:\n\n" + ideal_sentences.join(".")
puts "-- End of analysis"
