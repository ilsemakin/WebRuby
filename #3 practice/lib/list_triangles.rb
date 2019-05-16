# frozen_string_literal: true

# creating list of triangles
class ListTriangles
  def initialize
    @list = []
  end

  def add_triangle(triangle)
    @list << triangle
  end

  def each
    @list.each { |triangle| yield triangle }
  end
end
