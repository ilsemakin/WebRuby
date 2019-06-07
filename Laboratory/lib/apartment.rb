# frozen_string_literal: true

# creating one apartment
class Apartment
  attr_reader :footage, :rooms, :address, :floor
  attr_reader :type_of_house, :number_of_floors, :cost

  def initialize(footage, rooms, address, floor, type_of_house, number_of_floors, cost)
    @footage = footage.to_i
    @rooms = rooms.to_i
    @address = address
    @floor = floor.to_i
    @type_of_house = type_of_house
    @number_of_floors = number_of_floors.to_i
    @cost = cost.to_i
  end

  def check_fields
    errors = {}

    check_empty(errors)
    check_negative(errors)
    check_floor(errors)

    errors
  end

  private

  def check_empty(errors)
    message = 'This field cannot be empty!'

    errors[:district] = message if @address.district.empty?
    errors[:street] = message if @address.street.empty?
  end

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
