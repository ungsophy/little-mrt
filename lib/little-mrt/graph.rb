module LittleMRT
  class Graph

    DELIMITER = '-'

    attr_reader :matrix, :search_engine

    def initialize(data_path = nil)
      data_loader    = DataLoader.new
      @matrix        = data_loader.load_matrix
      @search_engine = SearchEngine.new(self)
    end

    def search(query, options = {})
      stations = query.gsub(/\-/, '')

      paths = direct_path(stations)
      paths = search_engine.search(stations, options) if paths.empty? && stations.length == 2

      paths
    end

    private
      def direct_path(stations)
        adjs = matrix.parse(stations)

        return Paths.new if adjs.empty?
        Paths.new(Path.new(adjs))
      end
  end
end
