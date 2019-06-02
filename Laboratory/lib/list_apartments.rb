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

  def sort_by_footage
    new_list = @list.sort_by(&:footage)

    new_list
  end

  def sort_by_cost
    new_list = @list.sort_by(&:cost)

    new_list
  end
end
