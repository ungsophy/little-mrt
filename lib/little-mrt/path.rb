module LittleMRT
  class Path

    attr_reader :adjacencies

    def initialize(adjacencies = [])
      @adjacencies = adjacencies
    end

    def add_adjacency(adjacency)
      if adjacencies.empty? || last_adjacency.to == adjacency.from
        adjacencies << adjacency
      else
        raise ArgumentError, "Last adjacency is not connected. #{last_adjacency.to} == #{adjacency.from}"
      end
    end
    alias_method :<<, :add_adjacency

    def last_adjacency
      adjacencies.last
    end

    def distance
      adjacencies.inject(0) { |result, adjacency| result += adjacency.distance }
    end

    def stops_count
      adjacencies.size
    end

    def to_s
      str, n = '', adjacencies.size - 1
      adjacencies.each_with_index do |adjacency, index|
        str += "#{adjacency.from}-"
        if index == n
          return str += "#{adjacency.to}"
        end
      end
    end
  end
end
