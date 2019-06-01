# frozen_string_literal: true

# creating parameters for swap
class Swap
  attr_reader :range_footage, :range_rooms, :list_district, :list_floors, :range_cost

  def initialize(range_footage, range_rooms, list_district, list_floors, range_cost)
    @range_footage = range_footage
    @range_rooms = range_rooms
    @list_district = list_district
    @list_floors = list_floors
    @range_cost = range_cost
  end
end
