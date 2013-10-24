require_relative '../../test_helper'

describe LittleMRT::Paths do
  let(:station_a) { LittleMRT::Station.new('A') }
  let(:station_b) { LittleMRT::Station.new('B') }
  let(:station_c) { LittleMRT::Station.new('C') }
  let(:station_d) { LittleMRT::Station.new('D') }
  let(:adjacency_ab) { LittleMRT::Adjacency.new(station_a, station_b, 10) }
  let(:adjacency_bc) { LittleMRT::Adjacency.new(station_b, station_c, 5) }
  let(:adjacency_cd) { LittleMRT::Adjacency.new(station_c, station_d, 8) }
  let(:path1) { LittleMRT::Path.new([adjacency_ab, adjacency_bc, adjacency_cd]) }
  let(:path2) { LittleMRT::Path.new([adjacency_ab, adjacency_cd]) }
  let(:paths) { LittleMRT::Paths.new(path1, path2) }

  describe '#max_stop' do
    it 'returns only paths that have match criterial' do
      filtered_paths = paths.max_stop(3)
      filtered_paths.size.must_equal 2
    end
  end

  describe '#stop' do
    it 'returns only paths that have match criterial' do
      filtered_paths = paths.max_stop(2)
      filtered_paths.size.must_equal 1
    end
  end

  describe '#min_distance' do
    it 'returns only path that have match criterial' do
      path = paths.min_distance

      path.distance.must_equal 18
    end
  end

  describe '#max_distance' do
    it 'returns only paths that have match criterial' do
      filtered_paths = paths.max_distance(15)
      filtered_paths.must_be_empty

      filtered_paths = paths.max_distance(24)
      filtered_paths.size.must_equal 2
    end
  end
end
