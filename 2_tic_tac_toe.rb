require 'pry-byebug'

class Board 
  def self.create
    (1..9).each_with_object({}) do |position, game_grid|
      game_grid[position] = position
    end
  end

end

class OtherThing  # not sure what I'll call it quite yet. Thi
  def initialize()
    # binding.pry
    @board = Board.create
  end

  def print_the_thing
    @board
  end
end

the_thing = OtherThing.new
puts the_thing.print_the_thing