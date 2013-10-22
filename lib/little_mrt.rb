module LittleMRT
  def self.root
    File.expand_path('..', __FILE__)
  end
end

require 'yaml'
require 'forwardable'

require_relative 'little-mrt/graph'
require_relative 'little-mrt/station'
require_relative 'little-mrt/adjacency'
require_relative 'little-mrt/adjacency_matrix'
require_relative 'little-mrt/path'
require_relative 'little-mrt/paths'
require_relative 'little-mrt/data_loader'
