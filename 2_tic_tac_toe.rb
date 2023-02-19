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
  def self.call
    {
      "loss" => "Loss - placeholder.",
      "draw" => "It's a draw!", 
      "winner" => "Wowza, you win - congratulations and whatnot!"
    }
  end
end

class OtherThing  # not sure what I'll call it quite yet. Thi
  def initialize()
    # binding.pry
    @board = Board.create
    @player_one = Player.new("X").char
    @player_two = Player.new("O").char
    @winning_combos = WinningCombos.call 
    @outcome_messages = Result.call
  end

  def print_the_thing   # just testing that we're getting those variables from the other class :D
    binding.pry
    @outcome_messages.to_s
  end
end

the_thing = OtherThing.new
puts the_thing.print_the_thing