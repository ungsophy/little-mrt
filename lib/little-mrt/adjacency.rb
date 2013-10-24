LittleMRT::Adjacency = Struct.new(:from, :to, :distance) do
  def to_s
    "#{from}#{to}#{distance}"
  end
end
