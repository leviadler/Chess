require 'spec_helper'
require 'board'
require 'pieces'

describe Stepable do
  let(:b) { Board.new(false) }

  describe '#moves' do
    it 'adds all open spaces upto the edge in one direction' do
      class P < Piece
        include Stepable
        def move_diffs
          [[0, 1]]
        end
      end
      p = P.new(:black, b, [0, 0])
      expect(p.moves).to eq([[0, 1]])
    end

    it 'adds all open spaces upto the edge in two directions' do
      class P3 < Piece
        include Stepable
        def move_diffs
          [[0, 1], [1, 0]]
        end
      end
      p2 = P3.new(:black, b, [0, 0])
      expect(p2.moves).to eq([[0, 1], [1, 0]])
    end

    it 'adds all open spaces upto the a same piece in one direction' do
      class P2 < Piece
        include Stepable
        def move_diffs
          [[0, 1]]
        end
      end
      p1 = P2.new(:black, b, [0, 0])
      p2 = P2.new(:black, b, [0, 1])
      b[[0, 0]] = p1
      b[[0, 1]] = p2
      expect(p1.moves).to eq([])
      expect(p2.moves).to eq([[0, 2]])
    end

    it 'adds open spaces upto and including enemy piece in one direction' do
      class P2 < Piece
        include Stepable
        def move_diffs
          [[0, 1]]
        end
      end
      p1 = P2.new(:black, b, [0, 0])
      p2 = P2.new(:white, b, [0, 1])
      b[[0, 0]] = p1
      b[[0, 1]] = p2
      expect(p1.moves).to eq([[0, 1]])
      expect(p2.moves).to eq([[0, 2]])
    end
  end
end
