module LittleMRT
  class Graph

    DELIMITER = '-'
    DATA_PATH = "#{::LittleMRT.root}/data.yml"

    attr_reader :stations, :matrix

    def initialize(data_path = nil)
      load_data(data_path)
    end

    def search(query)
      # stations = to_stations(query)
    end

    private
      def load_data(path)
        data = load_data_from_yaml(path)
        prepare_stations(data['stations'])
        prepare_matrix(data['adjacency_matrix'])
      end

      def prepare_matrix(adjacency_matrix)
        @matrix = AdjacencyMatrix.new(stations)

        stations.each do |from|
          stations.each do |to|
            if adjacency = find_adjacency(adjacency_matrix, from, to)
              matrix.add_adjacency(from, adjacency)
            end
          end
        end
      end

      def find_adjacency(adjacency_matrix, from, to)
        adjacency_matrix.each do |obj|
          if obj['from'] == from.label && obj['to'] == to.label
            return Adjacency.new(from, to, obj['distance'])
          end
        end

        nil
      end

      def prepare_stations(stations)
        @stations = stations.map { |label| Station.new(label) }
      end

      def load_data_from_yaml(path)
        path ||= DATA_PATH
        YAML.load(File.open(path))
      end

      def to_stations(query)
        query.split(DELIMITER)
      end
  end
end
