module GameNarration

  def start_game_narration
    start_game
    sleep (0.5)
    return if !to_play?
  end

  def display_already_played_message
    puts "Ope, that one's already taken. Choose again."
  end

  def invalid_resonse_message
    puts "Hm, not sure I understand... Please choose a number, 1 - 9."
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
      return
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
