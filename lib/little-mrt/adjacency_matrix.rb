module LittleMRT
  class AdjacencyMatrix

    attr_reader :matrix, :stations

    def initialize(stations)
      @stations = stations
      @matrix   = Hash[stations.map { |station| [station, []] }]
    end

    def add_adjacency(from, adjacency)
      matrix[from] << adjacency
    end
  end
end
