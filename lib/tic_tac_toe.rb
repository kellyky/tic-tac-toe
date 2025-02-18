class Board

  DISPLAY = ->(board) do
     <<-display

          #{board[1]} | #{board[2]} | #{board[3]}
          ---+---+---
          #{board[4]} | #{board[5]} | #{board[6]}
          ---+---+---
          #{board[7]} | #{board[8]} | #{board[9]}


    display
  end

  def self.create
    (1..9).each_with_object({}) do |position, grid|
      grid[position] = position
    end
  end
end

Player = Data.define(:char)

class WinningCombos
  def self.call
    [[1, 2, 3], [4, 5, 6], [7, 8, 9],
      [1, 4, 7], [2, 5, 8], [3, 6, 9],
      [1, 5, 9], [3, 5, 7]]
  end
end


class Result
  def self.call
    {
      'loss' => 'Loss - placeholder.',
      'draw' => "It's a draw!",
      'winner' => 'We have a winner!!!!'
    }
  end
end

class PlayTicTacToe

  TEXT_ANIMATION_PAUSE = 0

  TEXT = <<~message
    %s
  message

  private

  attr_accessor :player_one,
                :player_two,
                :board,
                :winning_combos,
                :computer_player,
                :turn_counter

  def initialize()
    self.board = Board.create
    self.player_one = Player.new('X').char
    self.player_two = Player.new('O').char
    self.winning_combos = WinningCombos.call
    self.computer_player = false
    self.turn_counter = 0
  end

  def play_again
    clear_board
    want_to_play?
    print_sleep display_board
    turn(player_one)
  end

  def want_to_play?
    puts TEXT % "Type 'y' or 'n'. "
    sleep TEXT_ANIMATION_PAUSE
    answer = gets.chomp

    case answer
    when 'y'
      print_sleep 'Woohoo!'
      how_many_players
    when 'n'
      print_sleep 'Alrighty - bye then!'
      exit
    else
      print_sleep "Hm, not sure I understand... Please type 'y' for 'yes' or 'n' for 'no'."
      want_to_play?
    end
  end

  def how_many_players
    print_sleep 'How many players?'
    print_sleep "Select '1' to play the computer and '2' to play a friend. "
    answer = gets.chomp.to_i

    case answer
    when 1
      self.computer_player = true
      print_sleep "\nYou want to play the computer, eh? You'll be 'X' and I, Hal (the computer), will be 'O'."
      print_sleep "It'll be fun - let's go!"
    when 2
      print_sleep "Preparing a new board... 'X' goes first. Choose a number, 1 - 9."
    else
      print_sleep "Hm, not sure I understand... Please choose 1 to play the computer or 2 to play a friend - or yourself."
      how_many_players
    end
  end

  def game_intro
    print_sleep 'Hello! Welcome to Tic Tac Toe. To win, be the first to get 3 in a row.'
    print_sleep 'Rows, columns, diagonals - any wins.'
  end

  def turn(player)
    self.turn_counter += 1
    other_player = player == player_one ? player_two : player_one

    print_sleep 'Player %s, your move: ' % player
    choice = gets.chomp

    if available_move?(player, choice)
      board[choice.to_i] = player
      print_sleep display_board
      check_outcome(player)
    else
      turn(player)
    end

    computer_player ? computer_turn : turn(other_player)
  end

  def computer_turn
    self.turn_counter += 1
    move = suggested_computer_moves.sample
    board[move] = player_two

    print_sleep "Hal chooses #{move}."
    print_sleep display_board

    check_outcome(player_two)
    turn(player_one)
  end

  def end_game(outcome)
    print_sleep Result.call[outcome].to_s
    print_sleep "Would you like to play_again? "
    play_again
  end

  def check_outcome(player)
    end_game("winner") if winner?(player)
    end_game("draw") if turn_counter == 9
  end

  def winner?(player)
    current_players_spots(player) == player
  end

  def current_players_spots(player)
    spots = board.map{ |spot, place|  spot if place == player }

    winning_combos.map { |combo| return player if (combo - spots).empty? }
  end

  def available
    board.values.select{ |v| v.is_a? Integer }
  end

  def player_one_occupies
    board.map{ |spot, place|  spot if place == player_one }.compact
  end

  def player_two_occupies
    board.map{ |spot, place|  spot if place == player_two }.compact
  end

  def player_one_winning_moves
    return [] if player_one_occupies.nil? || player_one_occupies.empty?
    moves = winning_combos.select{ |combo| (combo - player_one_occupies).length == 1 }.compact.flatten
    moves & available
  end

  def player_two_winning_moves
    return [] if player_two_occupies.nil? || player_two_occupies.empty?
    moves = winning_combos.select{ |combo| (combo - player_two_occupies).length == 1 }.compact.flatten
    moves & available
  end

  def suggested_computer_moves
    case
    when player_two_winning_moves.any?
      player_two_winning_moves
    when player_one_winning_moves.any?
      player_one_winning_moves
    else
      available
    end
  end

  def available_move?(player, choice)
    return true if board[choice.to_i] == choice.to_i

    if !choice.match?(/[1-9]/)
      print_sleep 'Hm... not sure I understand. Please choose a number, 1 - 9.'
    else
      print_sleep "Ope, that one's already taken. Choose again."
    end
    false
  end

  def display_board
    Board::DISPLAY[board]
  end

  def clear_board
    board.each { |place, val| board[place] = place }
    self.turn_counter = 0
    self.computer_player = false
  end

  def print_sleep(message)
    puts  TEXT % message
    sleep TEXT_ANIMATION_PAUSE
  end

  public

  attr_reader :player_one,
              :player_two,
              :board,
              :winning_combos,
              :outcome_messages

  attr_writer :computer_player,
              :turn_counter

  def play
    game_intro
    how_many_players
    print_sleep display_board
    turn(player_one)
  end

end

