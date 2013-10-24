require_relative '../../test_helper'

describe 'Solutions' do
  let(:graph) { LittleMRT::Graph.new }

  describe 'Problem 1: A-B-C' do
    it 'returns path A-B-C' do
      paths = graph.search('A-B-C')
      paths.first.to_s.must_equal 'A-B-C'
      paths.first.distance.must_equal 9
    end
  end

  describe 'Problem 2: A-D' do
    it 'returns path A-D' do
      paths = graph.search('A-D')
      paths.first.to_s.must_equal 'A-D'
      paths.first.distance.must_equal 5
    end
  end

  describe 'Problem 3: A-D-C' do
    it 'returns path A-D-C' do
      paths = graph.search('A-D-C')
      paths.first.to_s.must_equal 'A-D-C'
      paths.first.distance.must_equal 13
    end
  end

  describe 'Problem 4: A-E-B-C-D' do
    it 'returns path A-E-B-C-D' do
      paths = graph.search('A-E-B-C-D')
      paths.first.to_s.must_equal 'A-E-B-C-D'
      paths.first.distance.must_equal 22
    end
  end

  describe 'Problem 5: A-E-D' do
    it 'returns an empty paths' do
      paths = graph.search('A-E-D')
      paths.must_be_empty
    end
  end

  describe 'Problem 6: C-C with maximum 3 stops' do
    it 'returns only paths that have maximum 3 stops' do
      paths          = graph.search('C-C')
      filtered_paths = paths.max_stop(3)

      filtered_paths.size.must_equal 2
      filtered_paths.first.to_s.must_equal 'C-D-C'
      filtered_paths.last.to_s.must_equal 'C-E-B-C'
      filtered_paths.each { |path| path.stops_count.must_be :<=, 3 }
    end
  end

  describe 'Problem 7: A-C with exactly 4 stops' do
    it 'returns only paths that have exactly 4 stops' do
      paths          = graph.search('A-C', stop: 4)
      filtered_paths = paths.stop(4)

      filtered_paths.size.must_equal 3
      filtered_paths[0].to_s.must_equal 'A-B-C-D-C'
      filtered_paths[0].stops_count.must_equal 4

      filtered_paths[1].to_s.must_equal 'A-D-C-D-C'
      filtered_paths[1].stops_count.must_equal 4

      filtered_paths[2].to_s.must_equal 'A-D-E-B-C'
      filtered_paths[2].stops_count.must_equal 4
    end
  end

  describe 'Problem 8: A-C with shortest distance' do
    it 'returns only path that have shortest distance' do
      paths = graph.search('A-C')
      path = paths.min_distance

      path.to_s.must_equal 'A-B-C'
      path.distance.must_equal 9
    end
  end

  describe 'Problem 9: B-B with shortest distance' do
    it 'returns only path that have shortest distance' do
      paths = graph.search('B-B')
      path = paths.min_distance

      path.to_s.must_equal 'B-C-E-B'
      path.distance.must_equal 9
    end
  end

  describe 'Problem 10: C-C with distance less than 30' do
    it 'returns only paths that have distance less than 30' do
      paths = graph.search('C-C', distance: 30)
      filtered_paths = paths.max_distance(30)

      filtered_paths.size.must_equal 7
      filtered_paths.each { |path| path.distance.must_be :<, 30 }

      filtered_paths[0].to_s.must_equal 'C-D-C'
      filtered_paths[1].to_s.must_equal 'C-D-C-E-B-C'
      filtered_paths[2].to_s.must_equal 'C-D-E-B-C'
      filtered_paths[3].to_s.must_equal 'C-E-B-C'
      filtered_paths[4].to_s.must_equal 'C-E-B-C-D-C'
      filtered_paths[5].to_s.must_equal 'C-E-B-C-E-B-C'
      filtered_paths[6].to_s.must_equal 'C-E-B-C-E-B-C-E-B-C'
    end
  end
end
