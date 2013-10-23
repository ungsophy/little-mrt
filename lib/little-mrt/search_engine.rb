module LittleMRT
  class SearchEngine

    DELIMITER = ';'

    attr_reader :graph

    def initialize(graph)
      @graph = graph
    end

    def search(stations, options = {})
      from = Station.new(stations[0])
      to   = Station.new(stations[1])

      str_paths = query_path(from, to, from.label, options)
      str_paths = clean_string_paths(str_paths)
      to_paths(str_paths)
    end

    private
      def matrix
        graph.matrix
      end

      def to_paths(str_paths)
        paths = str_paths.split(DELIMITER).map do |str_path|
                  adjs = matrix.parse(str_path)
                  Path.new(adjs)
                end
        Paths.new(*paths)
      end

      def clean_string_paths(str_paths)
        str_paths.gsub(/;[a-zA-Z]$/, '')
      end

      def query_path(from, to, str, options)
        adjs = matrix.adjacencies_of(from)
        adjs.each_with_index do |adj, index|
          str = if adj.to != to
                  not_yet_reach_destination(adj, to, str, options)
                else
                  if satisfied_stop_option?(str, options)
                    not_yet_reach_destination(adj, to, str, options)
                  elsif satisfied_distance_option?(str, to, options)
                    str = path_reach_destination(to, str)
                    not_yet_reach_destination(adj, to, str, options)
                  else
                    path_reach_destination(to, str)
                  end
                end
        end

        str
      end

      def satisfied_stop_option?(str, options)
        options[:stop] && options[:stop] > str.split(DELIMITER).last.length
      end

      def satisfied_distance_option?(str, to, options)
        if options[:distance]
          adjs = matrix.parse("#{str.split(DELIMITER).last}#{to.label}")
          options[:distance] > Path.new(adjs).distance
        else
          false
        end
      end

      def not_yet_reach_destination(adj, to, str, options)
        if deadlock?(str, adj.to.label) && options.empty?
          str += '0'
        else
          str += "#{adj.to}"
          str = query_path(adj.to, to, str, options)
        end

        str.slice(0, str.length - 1)
      end

      def path_reach_destination(to, str)
        str = "#{str}#{to.label}#{DELIMITER}"
        tmp = str.split(';')[-1]
        str + tmp.slice(0, tmp.length - 1)
      end

      def deadlock?(path, to)
        path[-2] == to
      end
  end
end
