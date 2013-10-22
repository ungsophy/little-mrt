module LittleMRT
  class Graph

    DELIMITER = '-'

    attr_reader :matrix, :search_engine

    def initialize(data_path = nil)
      data_loader    = DataLoader.new
      @matrix        = data_loader.load_matrix
      @search_engine = SearchEngine.new(self)
    end

    def search(query)
      stations = to_stations(query)

      paths = direct_path(stations)
      paths = search_engine.search(stations.first, stations.last) if paths.empty? && stations.size == 2

      paths
    end

    private
      def direct_path(stations)
        path  = Path.new
        paths = Paths.new
        n     = stations.size - 1

        stations.each_index do |i|
          if n == i
            paths << path
            return paths
          end

          path << matrix.adjacency!(stations[i], stations[i + 1])
        end
      rescue AdjacencyNotFound
        paths
      end

      def to_stations(query)
        query.split(DELIMITER).map { |label| Station.new(label) }
      end
  end
end
