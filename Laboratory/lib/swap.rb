# frozen_string_literal: true

require_relative 'checks'

# creating parameters for swap
class Swap
  include Check
  attr_reader :range_footage, :range_rooms, :list_districts, :list_floors, :range_cost

  def initialize(range_footage, range_rooms, list_districts, list_floors, range_cost)
    @range_footage = range_footage
    @range_rooms = range_rooms
    @list_districts = list_districts
    @list_floors = list_floors
    @range_cost = range_cost
  end

  def check_fields
    errors = {}
    message_range = 'Check range!'
    message_floors = 'Invalid floors'

    errors[:range_footage] = message_range if Check.range(@range_footage)
    errors[:range_rooms] = message_range if Check.range(@range_rooms)
    errors[:range_cost] = message_range if Check.range(@range_cost)
    errors[:list_floors] = message_floors if Check.floors(@list_floors)

    errors
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
