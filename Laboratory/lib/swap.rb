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

  def check_fields
    errors = {}

    check_range(errors, @range_footage, @range_rooms, @range_cost)
    check_floors(errors)

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

  private

  def check_range(errors, *ranges)
    message = 'Check range!'
    ranges.each { |range| errors.store(range, message) if Check.range(range) }
  end

  def check_floors(errors)
    message = 'Invalid floors!'
    errors[:list_floors] = message if Check.floors(@list_floors)
  end
end
