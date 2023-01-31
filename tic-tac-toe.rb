require 'pry-byebug'
require_relative 'game_chatter'

class TicTacToeBoard
  include GameChatter
  include Moves
  include WinningCombos

  def initialize(moves, *spaces)
    # binding.pry
    @moves = MOVES

    @board = "\n #{@moves[1]} | #{@moves[2]} | #{@moves[3]} #{border} #{@moves[4]} | #{@moves[5]} | #{@moves[6]} #{border} #{@moves[7]} | #{@moves[8]} | #{@moves[9]}\n\n"

    # @board = "\n #{@moves[a]} | #{@moves[b]} | #{@moves[c]} #{border} #{@moves[d]} | #{@moves[e]} | #{@moves[f]} #{border} #{@moves[g]} | #{@moves[h]} | #{@moves[i]}\n\n"
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
  include Moves
  include WinningCombos

  def initialize
    @board = TicTacToeBoard.new(@moves, spaces)
    @moves = MOVES
  end

  def spaces

  end

  def check_for_winner(player)
    spots = []
    @moves.each do |spot, pl|
      if pl == player
        spots << spot
      end
    end

    spots
  end

  def player_turns
    # binding.pry
    turn_counter = 0

    while turn_counter < 9
      if turn_counter.even?
        player_one_turn
        puts MOVES
        puts print_board
        sleep (0.5)
      else
        player_two_turn
        puts MOVES
        puts print_board
        sleep (0.5)
      end
      turn_counter += 1
    end
  end 

  def player_one_turn
    puts "Player 1, your move: "
    choice = gets.chomp.to_i

    case
    when already_played(choice)
      display_already_played_message
      player_one_turn
    when invalid_choices(choice)
      invalid_response
      player_two_turn
    else
      @moves[choice] = "X"
    end

    if check_for_winner('X')
      return "X wins!"
    end
  end

  def player_two_turn
    puts "Player 2, your move: "
    choice = gets.chomp.to_i

    case
    when already_played(choice)
      display_already_played_message
      player_two_turn
    when invalid_choices(choice)
      invalid_response
      player_two_turn
    else
      @moves[choice] = "O"
    end

    if check_for_winner('O')
      return "O wins!"
    end
  end
    

  def invalid_choices(move)
    !@moves.keys.include?(move)
  end  

  def already_played(move)
    !@moves.values.include?(move)
  end

  def start_new_game
    start_game_narration
    player_turns
  end
  
  def update_moves_player_one(moves)
    MOVES[choice] = "X"

    puts @board
  end

  def print_board
    puts @board.board
  end
end

game = GamePlay.new
puts game.print_board()
# puts game::start_game_narration
# puts game.player_turns
puts game.start_new_game
