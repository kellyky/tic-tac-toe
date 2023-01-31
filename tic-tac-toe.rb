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

    spots

    WINNING_COMBOS.each do |combo| 
      diff = combo - spots
      if diff.empty?
        return "We have a winnder - player #{player} wins!!!"
      end
    end
  end

  def player_turns
    turn_counter = 0

    while turn_counter < 9
      binding.pry
      if turn_counter.even?
        player_one_turn
        display_board
        check_for_winner("X")
        sleep (0.5)
      else
        player_two_turn
        display_board
        check_for_winner("O")
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
      @board[choice] = "X"
      # player_ones_moves << choice
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
      @board[choice] = "O"
      # player_twos_moves << choice
    end
  end
    

  def invalid_choices(move)
    !@board.keys.include?(move)
  end  

  def already_played(move)
    !@board.values.include?(move)
  end

  def start_new_game
    display_board
    start_game_narration
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
