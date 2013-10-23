module LittleMRT
  class Paths

    extend Forwardable
    def_delegators :paths, :size, :empty?, :first, :<<, :last, :each

    attr_reader :paths

    def initialize(*paths)
      @paths = paths
    end

    def max_stop(n)
      @paths.select { |path| path.stops_count <= n }
    end

    def stop(n)
      @paths.select { |path| path.stops_count == n }
    end

    def min_distance
      @paths.sort { |path1, path2| path1.distance <=> path2.distance }.first
    end

    def max_distance(n)
      @paths.select { |path| path.distance < n }
    end
  end
end
