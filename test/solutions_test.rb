require_relative 'test_helper'

describe 'Solutions' do
  let(:graph) { LittleMRT::Graph.new }

  describe 'Problem 1: A-B-C' do
    it 'returns path A-B-C' do
      paths = graph.search('A-B-C')
      paths.first.to_s.must_equal 'A-B-C'
      paths.first.distance.must_equal 9
    end
  end

end
