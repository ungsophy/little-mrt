require_relative '../../test_helper'

describe LittleMRT::DataLoader do
  describe '#load_matrix' do
    it 'loads data from yaml and creates adjacency matrix' do
      data_loader = LittleMRT::DataLoader.new("#{LittleMRT.root}/../test/data.yml")
      matrix      = data_loader.load_matrix

      adjs = matrix.adjacencies_of(LittleMRT::Station.new('A'))
      adjs.size.must_equal 3

      adjs = matrix.adjacencies_of(LittleMRT::Station.new('B'))
      adjs.size.must_equal 1

      adjs = matrix.adjacencies_of(LittleMRT::Station.new('C'))
      adjs.size.must_equal 2

      adjs = matrix.adjacencies_of(LittleMRT::Station.new('D'))
      adjs.size.must_equal 2

      adjs = matrix.adjacencies_of(LittleMRT::Station.new('E'))
      adjs.size.must_equal 1
    end
  end
end
