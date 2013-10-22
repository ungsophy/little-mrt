module LittleMRT
  class DataLoader

    DATA_PATH = "#{LittleMRT.root}/data.yml"

    attr_reader :data_path

    def initialize(data_path = nil)
      @data_path = data_path
    end

    def load_matrix
      data = load_data_from_yaml
      prepare_matrix(data['stations'], data['adjacency_matrix'])
    end

    private
      def load_data_from_yaml
        path = data_path || DATA_PATH
        YAML.load(File.open(path))
      end

      def prepare_stations(stations)
        stations.map { |label| Station.new(label) }
      end

      def prepare_matrix(array_stations, adjacency_matrix)
        stations = prepare_stations(array_stations)
        matrix   = AdjacencyMatrix.new(stations)

        stations.each do |from|
          stations.each do |to|
            if adjacency = find_adjacency(adjacency_matrix, from, to)
              matrix.add_adjacency(from, adjacency)
            end
          end
        end

        matrix
      end

      def find_adjacency(adjacency_matrix, from, to)
        adjacency_matrix.each do |obj|
          if obj['from'] == from.label && obj['to'] == to.label
            return Adjacency.new(from, to, obj['distance'])
          end
        end

        nil
      end
  end
end
