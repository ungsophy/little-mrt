module LittleMRT
  class Adjacency

    attr_reader :from, :to, :distance

    def initialize(from, to, distance)
      @from     = from
      @to       = to
      @distance = distance
    end
  end
end
