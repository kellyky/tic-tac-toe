require 'pry-byebug'
require_relative 'game_chatter'

class GamePlay
  include GameChatter
  include Board
  include WinningCombos

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

  def player_turns
    turn_counter = 0

    while turn_counter < 9
      turn_counter.even? ? player_one_turn("X") : player_two_turn("O")
      turn_counter += 1
    end

    end_game("draw")
  end 

  def player_one_turn(player)
    puts "Player 1, your move: "
    choice = gets.chomp.to_i

    case
    when already_played(choice)
      display_already_played_message
      player_one_turn("X")
    when invalid_choices(choice)
      invalid_response
      player_two_turn("O")
    else
      @board[choice] = "X"
    end

    change_players(player)
  end

  def change_players(player)
    display_board
    end_game("winner") if check_for_winner(player) == player
    sleep (0.5)
  end

  def player_two_turn(player)
    puts "Player 2, your move: "
    choice = gets.chomp.to_i

    case
    when already_played(choice)
      display_already_played_message
      player_two_turn("X")
    when invalid_choices(choice)
      invalid_response
      player_two_turn("O")
    else
      @board[choice] = "O"
    end

    change_players(player)
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
    player_turns
  end

  def display_board
    border = "\n---+---+---\n"
    puts "\n #{@board[1]} | #{@board[2]} | #{@board[3]} #{border} #{@board[4]} | #{@board[5]} | #{@board[6]} #{border} #{@board[7]} | #{@board[8]} | #{@board[9]}\n\n"
  end

end

game = GamePlay.new
puts game.start_new_game
puts game.check_for_winner("X")
