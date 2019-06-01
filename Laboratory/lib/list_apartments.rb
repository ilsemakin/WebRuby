# frozen_string_literal: true

# creating list of apartments
class ListApartments
  def initialize
    @list = []
  end

  def add_apartment(apartment)
    @list << apartment
  end

  def each
    @list.each { |apartment| yield apartment }
  end
end
