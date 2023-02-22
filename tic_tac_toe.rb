require 'pry-byebug'

class Board 
  def self.create
    (1..9).each_with_object({}) do |position, grid|
      grid[position] = position
    end
  end
end

class Player
  attr_accessor :char

  def initialize(char)
    @char = char
  end
end

class WinningCombos 
  def self.call
    [[1, 2, 3], [4, 5, 6], [7, 8, 9],
      [1, 4, 7], [2, 5, 8], [3, 6, 9], 
      [1, 5, 9], [3, 5, 7]]
  end
end

class Result
  # Probably just put this in the actual play tic tac toe class
  def self.call
    {
      "loss" => "Loss - placeholder.",
      "draw" => "It's a draw!", 
      "winner" => "We have a winner!!!!"
    }
  end
end

class PlayTicTacToe 

  def initialize()
    @board = Board.create
    @player_one = Player.new("X").char
    @player_two = Player.new("O").char
    @winning_combos = WinningCombos.call 
    @outcome_messages = Result.call
    @computer_player = false
    @turn_counter = 0
  end

  def play
    game_intro
    want_to_play?
    display_board
    turn(@player_one)
  end

  def want_to_play?
    print_sleep ("Type 'y' or 'n'.")
    answer = gets.chomp

    case answer
    when 'y'
      print_sleep "\nWoohoo!" 
      how_many_players
      print_sleep "Preparing a new board... 'X' goes first. Choose a number, 1 - 9."
    when 'n'
      print_sleep "\nAlrighty - bye then!"
      exit
    else
      print_sleep "Hm, not sure I understand... Please type 'y' for 'yes' or 'n' for 'no'."
      want_to_play?
    end
  end

  def how_many_players
    print_sleep "How many players? Select 1 to play the computer and 2 to play a friend."
    answer = gets.chomp.to_i

    case answer
    when 1
      @computer_player = true
      print_sleep "Ooh, you DARE play the computer? So be it. But you've been warned..."
      # sleep(1)
      print_sleep "So be it. But you've been warned..."
      # sleep(1)
      print_sleep "Anywho: you'll be 'X' and I, the computer, will be 'O'."
      print_sleep "It'll be fun - let's go!"
    when 2
      print_sleep "Preparing a new board... 'X' goes first. Choose a number, 1 - 9."
    else
      print_sleep "Hm, not sure I understand... Please choose 1 to play the computer or 2 to play a friend - or yourself."
      how_many_players
    end
  end

  def game_intro
    print_sleep "Hello! Welcome to Tic Tac Toe. To win, be the first to get 3 in a row. Rows, columns, diagonals - any wins."
    "Would you like to play?"
  end

  def turn(player)
    @turn_counter += 1
    other_player = player == @player_one ? @player_two : @player_one

    print_sleep "Player #{player}, your move: \n"
    choice = gets.chomp

    if available_move?(player, choice)
      @board[choice.to_i] = player
      display_board
      check_outcome(player)
    else
      turn(player)
    end

    @computer_player ? computer_turn : turn(other_player)
  end

  def computer_turn
    current_players_spots(@player_one)
    binding.pry

    computers_move = list_available_moves.sample 
    print_sleep "Player #{@player_two}, your move: #{computers_move}\n"
    @board[computers_move] = @player_two
    check_outcome(@player_two)
    display_board
    turn(@player_one)
  end

  def end_game(outcome)
    print_sleep @outcome_messages[outcome].to_s
    print_sleep "Would you like to play_again? "
    clear_board
    want_to_play?
  end

  def check_outcome(player)
    end_game("winner") if winner?(player) 
    end_game("draw") if @turn_counter == 9
  end

  def winner?(player)  
    current_players_spots(player) == player
  end

  def current_players_spots(player)
    spots = @board.map{ |spot, place|  spot if place == player }
  
    @winning_combos.map { |combo| return player if (combo - spots).empty? }
  end

  def list_available_moves
    available_spaces = @board.values.select{ |v| v.is_a? Integer }

    spots = @board.map{ |spot, place|  spot if place == @player_one }.compact
    p1_winning_moves = @winning_combos.map{ |combo| (combo - spots) if (combo - spots).length == 1 }.compact.flatten
    available_spaces & p1_winning_moves
  end

  def available_move?(player, choice)
    return true if @board[choice.to_i] == choice.to_i

    if !choice.match?(/[1-9]/)
      print_sleep "Hm... not sure I understand. Please choose a number, 1 - 9."
    else
      print_sleep "Ope, that one's already taken. Choose again."
    end
    false
  end

  def display_board
    border = "\n---+---+---\n"
    puts "\n #{@board[1]} | #{@board[2]} | #{@board[3]} #{border} #{@board[4]} | #{@board[5]} | #{@board[6]} #{border} #{@board[7]} | #{@board[8]} | #{@board[9]}\n\n"
  end

  def clear_board
    @board.each { |place, val| @board[place] = place }
    @turn_counter = 0
  end

  def print_sleep(message)
    puts message
    sleep(0.25)
  end
end

PlayTicTacToe.new.play