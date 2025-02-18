require './lib/tic_tac_toe'

describe Board do
  # will always be a 3 x 3 board of 1..9 
  # because this doesn't vary, does it make any sense to test?
  subject { described_class.create }

  it { expect(subject.class).to be(Hash) }
  it { expect(subject.keys).to eq(subject.values) }
end

describe Player do
  subject { described_class.new(char) }
  let(:char) { :x }

  describe '.initialize' do
    it 'returns the character entered' do
      expect(subject.char).to eq(char)
    end
  end
end

describe Result do
  describe '.call' do
    it { expect(described_class.call.class).to be(Hash) }
    it { expect(described_class.call["loss"].match?(/[a-z]*loss[a-z]*/i)).to be (true) }
    it { expect(described_class.call["draw"].match?(/[a-z]*draw[a-z]*/i)).to be (true) }
    it { expect(described_class.call["winner"].match?(/[a-z]*win[a-z]*/i)).to be (true) }
  end
end

describe PlayTicTacToe do
  describe '.initialize' do
    # it { expect(@board).to_receive(::Board.create) }
    it '...' do
        expect(@board).should_receive(::Board.create) 
      # What to even test here
    end
  end

  describe '.play' do
    it 'calls game_play' do
      # FIXME - what I think I *want* to do is test that game_intro gets called
      # I don't think I would care about the 1... 
      expect(subject.send :game_intro).to eq(1)
    end

    it 'calls want_to_play?' do
      # how? subject.send trips on gets. I found a solution to use stdin... don't feel like it today. 
      # Reference: https://hackernoon.com/how-to-use-rspec-from-basics-to-testing-user-input-i03k36m3
    end

    it 'calls display_board' do # TODO better message
      expect((subject.send :display_board).class).to be(String)
    end

    it 'calls turn and passes @player_1 as the arg' do
      # how? I think what I want to test here is that turn gets called with player_1 as the arg
      # expect(subject.turn(@player_1)).to call(turn)   # doesn't do the trick but leaving the thought there
    end
  end

  describe '#play_again' do
    it 'calls clear_board' do
    end

    it 'calls want_to_play?' do
    end

    it 'calls display_board' do # should instead be calls print_sleep and passes display_board?
    end

    it 'it calls turn and passes @player_1 as the arg' do
    end
  end

  describe '#want_to_play?' do
  end

  describe '#how_many_players' do
  end

  describe '#game_intro' do
    it 'calls print_sleep' do
      expect(:print_sleep).to receive(:game_intro).twice

    end
  end

  describe '#turn' do
  end

  describe '#computer_turn' do
  end
  
  describe '#end_game' do
  end

  describe '#check_outcome' do
  end

  describe '#winner?' do
  end

  describe '#current_players_spots' do
  end

  describe '#available' do
  end

  describe '#player_one_occupies' do
  end
  
  describe '#player_two_occupies' do
  end

  describe '#player_one_winning_moves' do
  end
   
  describe '#player_two_winning_moves' do
  end

  describe '#suggested_computer_moves' do
  end

  describe '#available_move?' do
  end

  describe '#display_board' do
  end

  describe '#clear_board' do
    it '...' do
    end
  end

  describe '#print_sleep' do
    # outputs the message it's passed
    # the timer
  end
end


