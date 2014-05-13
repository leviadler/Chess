require 'spec_helper'
require 'board'
require 'pieces'

describe Board do
  subject(:b) { Board.new }

  describe '#[]' do
    it 'has a [] getter method' do
      expect(b).to respond_to(:[])
    end

    it 'raises an exception if the position is invalid' do
      expect do
        b[[9, 9]]
      end.to raise_exception('invalid position')
    end
  end

  describe '#[]=' do
    it 'has a []= getter method' do
      expect(b).to respond_to(:[]=)
    end

    it 'raises an exception if the position is invalid' do
      expect do
        pos = 9, 9
        b[pos] = :blah
      end.to raise_exception('invalid position')
    end
  end

  describe '#in_check?' do
    it 'correctly checks for a board that is not in check' do
      expect(b).not_to be_in_check(:black)
      expect(b).not_to be_in_check(:white)
    end

    it 'correctly checks for a board that IS in check' do
      b2 = Board.new(false)
      b2[[4, 4]] = Queen.new(:black, b2, [4, 4])
      b2[[4, 6]] = King.new(:white, b2, [4, 6])
      b2[[0, 0]] = King.new(:black, b2, [0, 0])
      expect(b2).to be_in_check(:white)
      expect(b2).not_to be_in_check(:black)
    end
  end

  describe '#checkmate?' do
    it 'correctly checks for a board that is not in checkmate' do
      b2 = Board.new(false)
      b2[[4, 4]] = Queen.new(:black, b2, [4, 4])
      b2[[4, 6]] = King.new(:white, b2, [4, 6])
      b2[[0, 0]] = King.new(:black, b2, [0, 0])
      expect(b2).not_to be_checkmate(:white)
      expect(b2).not_to be_checkmate(:black)
    end

    it 'correctly checks for a board that IS in checkmate' do
      b2 = Board.new(false)
      b2[[1, 4]] = Rook.new(:black, b2, [1, 4])
      b2[[0, 4]] = Rook.new(:black, b2, [0, 4])
      b2[[4, 6]] = King.new(:black, b2, [4, 6])
      b2[[0, 0]] = King.new(:white, b2, [0, 0])
      expect(b2).to be_checkmate(:white)
      expect(b2).not_to be_checkmate(:black)
    end
  end

  describe '::new(true)' do
    it 'adds pawns to grid' do
      expect(b[[1, 1]].class).to eq(Pawn)
      expect(b[[6, 6]].class).to eq(Pawn)
      expect(b[[6, 6]].color).to eq(:white)
    end

    it 'adds rook to grid' do
      expect(b[[0, 0]].class).to eq(Rook)
      expect(b[[0, 0]].color).to eq(:black)
      expect(b[[0, 7]].class).to eq(Rook)
      expect(b[[7, 0]].class).to eq(Rook)
      expect(b[[7, 7]].color).to eq(:white)
    end

    it 'adds knights to grid' do
      expect(b[[0, 1]].class).to eq(Knight)
      expect(b[[0, 1]].color).to eq(:black)
      expect(b[[0, 6]].class).to eq(Knight)
      expect(b[[7, 1]].class).to eq(Knight)
      expect(b[[7, 6]].color).to eq(:white)
    end

    it 'adds bishops to grid' do
      expect(b[[0, 2]].class).to eq(Bishop)
      expect(b[[0, 2]].color).to eq(:black)
      expect(b[[0, 5]].class).to eq(Bishop)
      expect(b[[7, 2]].class).to eq(Bishop)
      expect(b[[7, 5]].color).to eq(:white)
    end

    it 'adds kings to grid' do
      expect(b[[0, 4]].class).to eq(King)
      expect(b[[0, 4]].color).to eq(:black)
      expect(b[[7, 4]].class).to eq(King)
      expect(b[[7, 4]].color).to eq(:white)
    end

    it 'adds queens to grid' do
      expect(b[[0, 3]].class).to eq(Queen)
      expect(b[[0, 3]].color).to eq(:black)
      expect(b[[7, 3]].class).to eq(Queen)
      expect(b[[7, 3]].color).to eq(:white)
    end
  end

  it '#empty? returns true if a space is empty' do
    expect(b.empty?([4, 4])).to be(true)
    expect(b.empty?([0, 0])).to be(false)
  end

  it 'displays nicely' do
    # this is for you :)
    b.display
  end
end
