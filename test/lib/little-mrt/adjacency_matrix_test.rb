require_relative '../../test_helper'

describe LittleMRT::AdjacencyMatrix do
  let(:station_a) { LittleMRT::Station.new('A') }
  let(:station_b) { LittleMRT::Station.new('B') }
  let(:stations) { [station_a, station_b] }
  let(:adjacency) { LittleMRT::Adjacency.new(station_a, station_b, 10) }
  let(:adjacency_matrix) { LittleMRT::AdjacencyMatrix.new(stations) }

  describe '#add_adjacency' do
    it 'adds adjacency into matrix' do
      adjacency_matrix.add_adjacency(station_a, adjacency)

      adjacency_matrix.adjacencies_of(station_a).must_equal [adjacency]
    end
  end
end
