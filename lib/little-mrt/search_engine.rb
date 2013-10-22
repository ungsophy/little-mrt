module LittleMRT
  class SearchEngine

    attr_reader :graph

    def initialize(graph)
      @graph = graph
    end

    def search(from, to)
      str_paths = query_path(from, to, from.label)
      str_paths = clean_string_paths(str_paths)
      to_paths(str_paths)
    end

    private
      def matrix
        graph.matrix
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
  end
end
