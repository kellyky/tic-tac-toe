module GameChatter

  
  MOVES = {
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

  def play_dialogue
    start_game
    sleep (0.5)
    to_play?
    sleep (0.5)
    player_turns
  end

  def player_turns
    turn_counter = 0

    while turn_counter < 9
      if turn_counter.even?
        player_one_turn
        puts MOVES
      else 
        player_two_turn
        puts MOVES
      end
      turn_counter += 1
    end
  end

  def player_two_turn
    puts "Player 2, your move: "
    choice = gets.chomp.to_i

    case
    when already_played(choice)
      puts "Ope, that one's already taken. Choose again."
      player_two_turn
    when invalid_choices(choice)
      invalid_response
      player_two_turn
    else
      MOVES[choice] = "O"
      MOVES
    end
  end
  
  def player_one_turn
    puts "Player 1, your move: "
    choice = gets.chomp.to_i

    case
    when already_played(choice)
      puts "Ope, that one's already taken. Choose again."
      player_one_turn
    when invalid_choices(choice)
      invalid_response
      player_one_turn
    else
      MOVES[choice] = "X"
      MOVES
    end
  end

  def invalid_response
    puts "Gahhhh. Not sure what to do with that one. Please choose an available space."
  end

  def already_played(move)
    !MOVES.values.include?(move)
  end

  def invalid_choices(move)
    !MOVES.keys.include?(move)
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
      puts "Woohoo! Preparing a new board..."
    when 'no'
      puts "Alrighty - bye then!"
    else
      puts "Hm, not sure I understand... Please type 'y' for 'yes' or 'n' for 'no'."
      sleep(0.5)
      to_play?
    end
  end

  def start_game
    puts "Hello! Welcome to Tic Tac Toe. To win, be the first to get 3 in a row. Rows, columns, diagonals - any wins."
    sleep (0.5)
    puts "Would you like to play?"
  end
end
