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

    check_negative(errors)
    check_floor(errors)

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

  def check_negative(errors)
    message = 'Enter a positive number!'

    errors[:footage] = message if @footage <= 0
    errors[:rooms] = message if @rooms <= 0
    errors[:house] = message if @address.house <= 0
    errors[:cost] = message if @cost <= 0
  end

  def check_floor(errors)
    message_comparison = 'Floor does not exist!'
    message = 'Check entered floor!'

    errors[:floor] = message_comparison if @floor > @number_of_floors
    errors[:floor] = message if @floor <= 0
    errors[:number_of_floors] = message if @number_of_floors <= 0
  end
end
