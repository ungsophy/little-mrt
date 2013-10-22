module LittleMRT
  class Graph

    DELIMITER = '-'

    attr_reader :matrix

    def initialize(data_path = nil)
      data_loader = DataLoader.new
      @matrix     = data_loader.load_matrix
    end

    def search(query)
      stations = to_stations(query)

      paths = direct_path(stations)
      paths = search_path(stations.first, stations.last) if paths.empty? && stations.size == 2

      paths
    end

    private
      def search_path(from, to)
        str_paths = query_path(from, to, from.label)
        str_paths = clean_string_paths(str_paths)
        to_paths(str_paths)
      end

      def to_paths(str_paths)
        paths = str_paths.split(';').map do |str_path|
                  adjs = matrix.parse(str_path)
                  Path.new(adjs)
                end
        Paths.new(*paths)
      end

      def clean_string_paths(str_paths)
        str_paths.gsub(/;[a-zA-Z]$/, '')
      end

      def query_path(from, to, str)
        adjs = matrix.adjacencies_of(from)
        adjs.each_with_index do |adj, index|
          str = if adj.to != to
                  not_yet_reach_destination(adj, to, str)
                else
                  path_reach_destination(to, str)
                end
        end

        str
      end

      def not_yet_reach_destination(adj, to, str)
        if deadlock?(str, adj.to.label)
          str += '0'
        else
          str += "#{adj.to}"
          str = query_path(adj.to, to, str)
        end

        str.slice(0, str.length - 1)
      end

      def path_reach_destination(to, str)
        str = "#{str}#{to.label};"
        tmp = str.split(';')[-1]
        str + tmp.slice(0, tmp.length - 1)
      end

      def deadlock?(path, to)
        path[-2] == to
      end

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
