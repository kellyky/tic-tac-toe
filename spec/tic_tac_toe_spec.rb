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
end

describe PlayTicTacToe do

end


