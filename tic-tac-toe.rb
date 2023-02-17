require 'pry-byebug'
# require_relative 'game_chatter'

module BoardMappings
  BOARD = {
      1 => 1,
      2 => 2,
      3 => 3,
      4 => 4,
      5 => 5,
      6 => 6,
      7 => 7,
      8 => 8,
      9 => 9
    }

  WINNING_COMBOS = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                    [1, 4, 7], [2, 5, 8], [3, 6, 9], 
                    [1, 5, 9], [3, 5, 7]]
end

module GameNarration

  def start_game_narration
    start_game
    sleep (0.5)
    return if !to_play?
  end

  def to_play?
    answer_lookup = {
      'y' => 'yes',
      'n' => 'no'
    }

    puts "Type 'y' or 'n'."
    sleep(0.5)
    answer = gets.chomp
    response = answer_lookup[answer]

    case response
    when 'yes'
      puts "Woohoo! Preparing a new board... 'X' goes first."
    when 'no'
      puts "Alrighty - bye then!"
      exit
    else
      puts "Hm, not sure I understand... Please type 'y' for 'yes' or 'n' for 'no'."
      sleep(0.5)
      to_play?
    end
  end

  def end_game(ending)
    if ending == "draw"
      puts "It's a draw!"
    elsif ending == "winner"
      puts "Wowza, what a game. Placeholder text, and so on."
    end
    sleep(0.5)
    puts "Would you like to play again?"
    to_play?
  end

  def start_game
    puts "Hello! Welcome to Tic Tac Toe. To win, be the first to get 3 in a row. Rows, columns, diagonals - any wins."
    sleep (0.5)
    puts "Would you like to play?"
  end

end

class GamePlay
  include GameNarration
  include BoardMappings

  def initialize
    @board = BOARD
  end

  def check_for_winner(player)
    spots = []
    @board.each { |spot, pl| spots << spot if pl == player }

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
  
  def available_move?(player, choice)
    if !(choice).match?(/[1-9]/)
      puts "Hm, not sure I understand... Please choose a number, 1 - 9."
      return false
    else
      return true if @board[choice.to_i] == choice.to_i
      puts "Ope, that one's already taken. Choose again."
    end
    false
  end

  def player_turn(player)
    puts "Player #{player}, your move: "
    # choice = gets.chomp.to_i
    choice = gets.chomp

    if available_move?(player, choice)
      @board[choice.to_i] = player
      end_players_turn(player)
    else
      player_turn(player)
    end
  end
  
  def end_players_turn(player)
    display_board
    end_game("winner") if check_for_winner(player) == player
    sleep (0.5)
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