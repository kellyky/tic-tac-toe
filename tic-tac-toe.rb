require_relative 'game_chatter'

class Player
  def initialize (name, symbol)
    @name = name
    @symbol = symbol
  end

  def name
    @name 
  end

  def symbol
    @symbol
  end
end

class TicTacToeBoard
  def initialize
    @board = "\n 1 | 2 | 3 #{border} 4 | 5 | 6 #{border} 7 | 8 | 9 "
  end 

  def board
    @board
  end

  def border
    "\n---+---+---\n"
  end
end

class GamePlay
  include GameChatter

  def initialize(*players, board)
    @player_one = Player.new("Yannis", "X")
    @player_two = Player.new("Masha", "O")
    @board = TicTacToeBoard.new
  end

  # def wins
  #   # rows 123, 456, 789
  #   # cols 147, 258, 369
  #   # diag 159, 357 
  # end

  # def update_board(position, player_key)
  #   # @board.gsub(/#{position}/, player_key)
  #   @board[position] = player_key
  # end

  def player_two_symbol
    @player_two.symbol
  end

  def player_one_symbol
    @player_one.symbol
  end

  def player_one
    @player_one.name
  end

  def player_two
    @player_two.name
  end

  def print_board
    @board.board
  end
end

# new_board = TicTacToeBoard.new
# puts new_board.board

game = GamePlay.new("Yannis", "X")
puts game::play_dialogue
