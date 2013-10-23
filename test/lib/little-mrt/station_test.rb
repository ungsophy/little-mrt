require_relative '../../test_helper'

describe LittleMRT::Station do
  describe '#initialize' do
    it 'changes label to upcase' do
      station = LittleMRT::Station.new('a')
      station.label.must_equal 'A'
    end
  end

  describe '#==' do
    it 'supports comparision' do
      LittleMRT::Station.new('a').must_equal LittleMRT::Station.new('A')
    end
  end
end
