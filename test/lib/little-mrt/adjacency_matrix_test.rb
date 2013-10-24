require_relative '../../test_helper'

describe LittleMRT::AdjacencyMatrix do

  describe 'before adding adjacency' do
    describe '#initialize' do
      it 'creates matrix hash' do
        station = LittleMRT::Station.new('A')
        matrix = LittleMRT::AdjacencyMatrix.new([station])

        matrix.matrix[station].must_be_empty
      end
    end

    describe '#add_adjacency' do
      it 'adds adjacency into matrix' do
        station_a = LittleMRT::Station.new('A')
        station_b = LittleMRT::Station.new('B')
        adjacency = LittleMRT::Adjacency.new(station_a, station_b, 10)
        matrix = LittleMRT::AdjacencyMatrix.new([station_a, station_b])

        matrix.add_adjacency(station_a, adjacency)

        matrix.adjacencies_of(station_a).must_equal [adjacency]
      end
    end
  end

  describe 'after adding adjacency' do
    before do
      data_loader = LittleMRT::DataLoader.new("#{LittleMRT.root}/../test/data.yml")
      @matrix     = data_loader.load_matrix
    end

    describe '#parse' do
      it 'parses stations string into adjacencies' do
        stations = 'ABC'
        adjs = @matrix.parse(stations)

        adjs.size.must_equal 2
        adjs.first.to_s.must_equal 'AB5'
        adjs.last.to_s.must_equal 'BC4'
      end

      describe 'when adjacencies are not connected' do
        it 'returns empty array' do
          stations = 'ABD'
          adjs = @matrix.parse(stations)

          adjs.must_be_empty
        end
      end
    end

    describe '#adjacencies_of' do
      it 'returns ajacencies of a station' do
        station = LittleMRT::Station.new('A')
        adjs = @matrix.adjacencies_of(station)

        adjs.size.must_equal 3
      end
    end

    describe '#adjacency' do
      it 'returns adjacency of two stations' do
        from = LittleMRT::Station.new('A')
        to   = LittleMRT::Station.new('B')
        adj = @matrix.adjacency(from, to)

        adj.to_s.must_equal 'AB5'
      end
    end

    describe '#adjacency!' do
      describe 'when adjacency is not found' do
        it 'raises AdjacencyNotFound exception' do
          from = LittleMRT::Station.new('A')
          to   = LittleMRT::Station.new('C')

          -> { @matrix.adjacency!(from, to) }.must_raise(LittleMRT::AdjacencyNotFound)
        end
      end
    end
  end
end
