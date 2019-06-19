# frozen_string_literal: true

# creating one apartment
class Apartment
  attr_reader :footage, :rooms, :address, :floor, :swap
  attr_reader :type_of_house, :number_of_floors, :cost

  def initialize(footage, rooms, address, floor, type_of_house, number_of_floors, cost, swap)
    @footage = footage
    @rooms = rooms
    @address = address
    @floor = floor
    @type_of_house = type_of_house
    @number_of_floors = number_of_floors
    @cost = cost
    @swap = swap
  end

  def check_fields
    errors = {}

    check_empty(errors, @address.district, @address.street,
                @swap.list_districts, @swap.list_floors)
    check_negative_numbers(errors, @footage, @rooms, @address.house,
                           @floor, @number_of_floors, @cost)
    check_range(errors, @swap.range_footage, @swap.range_rooms,
                @swap.range_cost)
    check_floor_exist(errors)
    check_floors(errors)

    errors
  end

  def to_s
    str = "Footage: #{@footage}" \
          "\nRooms: #{@rooms}" \
          "\nAddress: #{@address}" \
          "\nFloor: #{@floor}" \
          "\nType of house: #{@type_of_house}" \
          "\nNumber of floors: #{@number_of_floors}" \
          "\nCost: #{@cost}" \
          "\nSwap: #{@swap}\n\n"
    str
  end

  private

  def check_empty(errors, *strings)
    message = 'String is empty!'
    strings.each { |string| errors.store(string, message) if string.empty? }
  end

  def check_negative_numbers(errors, *numbers)
    message = 'Input a positive number!'
    numbers.each { |number| errors.store(number, message) if number <= 0 }
  end

  def check_floor_exist(errors)
    message = 'Floor does not exist!'
    errors[:floor_exist] = message if @floor > @number_of_floors
  end

  def check_range(errors, *ranges)
    message = 'Check range!'
    ranges.each { |range| errors.store(range, message) if Check.range(range) }
  end

  def check_floors(errors)
    message = 'Invalid floors!'
    errors[:list_floors] = message if Check.floors(@swap.list_floors)
  end
end
