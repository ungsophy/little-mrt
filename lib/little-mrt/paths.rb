module LittleMRT
  class Paths

    extend Forwardable
    def_delegators :paths, :size, :empty?, :first, :<<, :last, :each, :[]

    attr_reader :paths

    def initialize(*paths)
      @paths = paths
    end

    def max_stop(n)
      arr = @paths.select { |path| path.stops_count <= n }
      Paths.new(*arr)
    end

    def stop(n)
      arr = @paths.select { |path| path.stops_count == n }
      Paths.new(*arr)
    end

    def min_distance
      @paths.sort { |path1, path2| path1.distance <=> path2.distance }.first
    end

    def max_distance(n)
      arr = @paths.select { |path| path.distance < n }
      Paths.new(*arr)
    end
  end
end
