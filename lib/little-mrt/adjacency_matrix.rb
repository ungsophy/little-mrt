module LittleMRT
  class AdjacencyNotFound < RuntimeError
  end

  class AdjacencyMatrix

    attr_reader :matrix, :stations

    def initialize(stations)
      @stations = stations
      @matrix   = Hash[stations.map { |station| [station, []] }]
    end

    def parse(str_path)
      adjacencies = []
      n           = str_path.length - 1

      str_path.length.times do |i|
        return adjacencies if i == n

        from = Station.new(str_path[i])
        to   = Station.new(str_path[i + 1])
        adjacencies << adjacency!(from, to)
      end
    rescue AdjacencyNotFound
      []
    end

    def add_adjacency(from, adjacency)
      matrix[from] << adjacency
    end

    def adjacencies_of(from)
      result = matrix.find { |station, _| station == from }
      result && result.last
    end

    def adjacency(from, to)
      adjacencies_of(from).find { |adjacency| adjacency.to == to }
    end

    def adjacency!(from, to)
      if adj = adjacency(from, to)
        return adj
      end

      raise AdjacencyNotFound
    end
  end
end
