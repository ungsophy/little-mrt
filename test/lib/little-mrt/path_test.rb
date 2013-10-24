require_relative '../../test_helper'

describe LittleMRT::Path do
  let(:station_a) { LittleMRT::Station.new('A') }
  let(:station_b) { LittleMRT::Station.new('B') }
  let(:station_c) { LittleMRT::Station.new('C') }
  let(:station_d) { LittleMRT::Station.new('D') }
  let(:adjacency_ab) { LittleMRT::Adjacency.new(station_a, station_b, 10) }
  let(:adjacency_bc) { LittleMRT::Adjacency.new(station_b, station_c, 5) }
  let(:adjacency_cd) { LittleMRT::Adjacency.new(station_c, station_d, 8) }
  let(:path) { LittleMRT::Path.new }
  let(:another_path) do
    path = LittleMRT::Path.new
    path.add_adjacency(adjacency_ab)
    path.add_adjacency(adjacency_bc)
    path
  end

  describe '#add_adjacency' do
    it 'adds adjacency successfully' do
      another_path.adjacencies.size.must_equal 2
    end

    describe 'when last adjacency is not connected' do
      it 'raises ArgumentError' do
        path.add_adjacency(adjacency_ab)

        -> { path.add_adjacency(adjacency_cd) }.must_raise(ArgumentError)
      end
    end
  end

  describe '#distance' do
    it 'returns distance' do
      another_path.distance.must_equal 15
    end
  end

  describe '#stops_count' do
    it 'returns stops count' do
      another_path.stops_count.must_equal 2
    end
  end

  describe '#to_s' do
    it 'returns string' do
      another_path.to_s.must_equal 'A-B-C'
    end
  end
end
