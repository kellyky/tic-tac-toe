# does it work to separate this? 
# is it a good idea to do so?

class GameEnding
  def initialize(outcome)
    @outcome = outcome
  end

  OUTCOME_MAPPING = {
    "draw" => "It's a draw!",
    "winner" => "Wowza, you win - placeholder text and whatnot"
  }

  def self.run_end_game
    OUTCOME_MAPPING[@outcome]
  end
end