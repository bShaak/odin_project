class Board
	def initialize
		@num_turns = 0
		@squares = ["0","1","2","3","4","5","6","7","8"]
	end

	def place_token(token, index)
		if(@num_turns < 9)
		 	@num_turns += 1
			@squares[index] = token unless @squares[index] == "X" || @squares[index] == "O"
		end
	end

	def clear_board
		@squares = ["0","1","2","3","4","5","6","7","8"]
		@num_turns = 0
	end

	def horizontal_winner?
		[0,3,6].each do |x|
			return true if @squares[x] == @squares[x+1] && @squares[x+1] == @squares[x+2]
		end
		return false
	end

	def vertical_winner?
		[0,1,2].each do |x|
			return true if @squares[x] == @squares[x+3] && @squares[x+3] == @squares[x+6]
		end
		return false
	end

	def diagonal_winner?
		return true if @squares[0] == @squares[4] && @squares[4] == @squares[8]
		return true if @squares[2] == @squares[4] && @squares[4] == @squares[6]
		return false
	end

	def has_winner?
		horizontal_winner? || vertical_winner? || diagonal_winner?
	end

	def is_full?
		@num_turns == 9
	end

	def show
		@squares.each_with_index do |x, y|
			puts "" if y % 3 == 0
			print " " + x
		end
		puts ""
	end
end

class Player
	attr_reader :name, :token
	def initialize(name, token)
		@name = name
		@token = token
	end
end

class Game
	def initialize()
		@turn = 0
		@board = Board.new
		@player1 = Player.new("Player 1", "X")
		@player2 = Player.new("Player 2", "O")
	end

	def next_player
		@turn % 2 == 0 ? @player1 : @player2
	end

	def prev_player
		@turn % 2 != 0 ? @player1 : @player2
	end

	def play_turn
		puts "#{next_player.name} please enter square selection"
		index = gets.chomp.to_i
		@board.place_token(next_player.token, index)
		@turn += 1
	end

	def has_winner?
		@board.has_winner?
	end

	def is_draw?
		return @board.is_full? unless @board.has_winner?
		return false
	end

	def reset_game
		@board.clear_board
	end

	def show_board
		@board.show
	end
end

game = Game.new
end_game = false

until end_game
	until game.has_winner? || game.is_draw?
		game.show_board
		game.play_turn
	end

	game.show_board
	puts game.has_winner? ? "#{game.prev_player.name} won the game!" : "Draw game!"
	game.reset_game
	puts "Play again? y/n"
	r = gets.chomp
	end_game = true if r == "n" || r == "N"
	end_game = false if r == "y" || r == "Y"
end


