module LittleMRT
  class Station

    attr_reader :label

    def initialize(label)
      @label = label.upcase
    end

    def ==(other)
      label == other.label
    end

    def to_s
      label
    end
  end
end
