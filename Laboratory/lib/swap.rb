# frozen_string_literal: true

require_relative 'checks'

# creating parameters for swap
class Swap
  attr_reader :range_footage, :range_rooms, :list_districts, :list_floors, :range_cost

  def initialize(range_footage, range_rooms, list_districts, list_floors, range_cost)
    @range_footage = range_footage
    @range_rooms = range_rooms
    @list_districts = list_districts
    @list_floors = list_floors
    @range_cost = range_cost
  end

  def to_s
    str = "\n\tFootage: #{@range_footage}" \
          "\n\tRooms: #{@range_rooms}" \
          "\n\tDistricts: #{@list_districts.join(', ')}" \
          "\n\tFloors: #{@list_floors.join(', ')}" \
          "\n\tCost: #{@range_cost}"
    str
  end
end
