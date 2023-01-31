require 'pry-byebug'
require_relative 'game_chatter'

class GamePlay
  include GameNarration
  include BoardMappings

  def initialize
    @board = BOARD
  end

  def check_for_winner(player)
    spots = []
    @board.each do |spot, pl|
      if pl == player
        spots << spot
      end
    end
    WINNING_COMBOS.map { |combo| return player if (combo - spots).empty? }
  end

  def alternate_player_turns
    turn_counter = 0
    while turn_counter < 9
      turn_counter.even? ? player_turn("X") : player_turn("O")
      turn_counter += 1
    end
    end_game("draw")
  end 

  def player_turn(player)
    other_player = (player == "X" ? "O" : "X")
    puts "Player #{player}, your move: "
    choice = gets.chomp.to_i

    case
    when already_played(choice)
      already_played_message
      player_turn(player)
    when invalid_choices(choice)
      invalid_move_message
      player_turn(other_player)
    else
      @board[choice] = player
    end
    end_players_turn(player)
  end
  
  def end_players_turn(player)
    display_board
    end_game("winner") if check_for_winner(player) == player
    sleep (0.5)
  end

  def invalid_choices(move)
    !@board.keys.include?(move)
  end  

  def already_played(move)
    !@board.values.include?(move)
  end

  def start_new_game
    start_game_narration
    display_board
    alternate_player_turns
  end

  def display_board
    border = "\n---+---+---\n"
    puts "\n #{@board[1]} | #{@board[2]} | #{@board[3]} #{border} #{@board[4]} | #{@board[5]} | #{@board[6]} #{border} #{@board[7]} | #{@board[8]} | #{@board[9]}\n\n"
  end

end

game = GamePlay.new
puts game.start_new_game
# puts game.check_for_winner("X")
