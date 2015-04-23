#hangman
require 'yaml'

class SecretWord
	def initialize
		@word = pick_random_word
		@letters_guessed = []
		@word.length.times do
			@letters_guessed.push("_")
		end
	end

	def update
		@word = pick_random_word
		@letters_guessed = []
		@word.length.times do
			@letters_guessed.push("_")
		end
	end

	def contains(letter)
		@word.include? letter
	end

	def reveal(letter)
		return if letter.length > 1
		correct_guess = false
		@word.split("").each_with_index do |l, i|
			if l == letter
				@letters_guessed[i] = l
				correct_guess = true
			end
		end
		puts @letters_guessed.join(" ")
		return correct_guess
	end

	def guessed?
		@word == @letters_guessed.join
	end

	def print
		puts @word
	end

	private

	def pick_random_word
		chosen = nil
		wordbank_file = "/home/beed/Documents/resources/wordbank/5desk.txt"
		File.foreach(wordbank_file).each_with_index do |line,i|
			line.rstrip!
			if line.length > 4 && line.length < 13
				chosen = line if rand < 1.0/(i+1)
			end
		end
		#puts chosen
		return chosen.downcase
	end
end

class Game
	def initialize
		@secret_word = SecretWord.new
		@turns = 0
		@is_game_over = false
	end

	def show
		@secret_word.reveal("")
	end

	def next_turn(guess)
		return finish_game if @turns == 9
		@turns += 1 unless @secret_word.reveal(guess)
		winner?
	end

	def game_over?
		return @is_game_over
	end

	def new_game
		@secret_word.update
		@turns = 0
		@is_game_over = false
	end

	private

	def winner?
		if @secret_word.guessed?
			puts "Winner!"
			finish_game
		else
			puts (10 - @turns).to_s + " guesses left."
		end
	end

	def finish_game
		@is_game_over = true
		puts "Game over."
		puts "The word was:"
		@secret_word.print
	end
		
end

def save_game(game)
	Dir.mkdir('saved_game') unless Dir.exists?('saved_game')
	File.open('saved_game/save.txt', 'w') {|f| f.write(YAML.dump(game))}
end

def open_saved_game
	YAML.load(File.read('saved_game/save.txt')) if File.exists?('saved_game/save.txt')
end
	
selection = nil

while !selection do
	puts "1. Start new game."
	puts "2. Load saved game."
	selection = gets.chomp
	selection = nil unless selection == "1" || selection == "2"
end

game = open_saved_game if selection == "2"
game = Game.new if selection == "1"
play_again = true

#game loop
while play_again do
	game.show
	while !game.game_over? do
		puts "Please make a guess, or type 'exit'"
		guess = gets.chomp
		if guess.downcase == "exit" 
			puts "Would you like to save your game? [Y/N]"
			save_game(game) unless "n" == gets.chomp.downcase
			puts "Thanks for playing."
			exit
		else
			game.next_turn(guess)
		end
	end
	response = nil
	while !response do
		puts "Would you like to play again? [Y/N]"
		response = gets.chomp
		response = nil unless response.downcase == "y" || response.downcase == "n"
		if response
			play_again = false if "n" == response.downcase
			game.new_game if "y" == response.downcase
		end
	end
end

puts "Thanks for playing."