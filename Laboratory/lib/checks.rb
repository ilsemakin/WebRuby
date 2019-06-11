# frozen_string_literal: true

# module checks
module Check
  def self.floors(floors)
    floors.any? { |number| number <= 0 }
  end

  def self.range(range)
    return true if range.first > range.end ||
                   range.first <= 0 ||
                   range.end <= 0

    false
  end

  def self.swap(apartment1, apartment2)
    if apartment1.swap.range_footage.include?(apartment2.footage) &&
       apartment1.swap.range_rooms.include?(apartment2.rooms) &&
       apartment1.swap.range_cost.include?(apartment2.cost) &&
       apartment1.swap.list_districts.include?(apartment2.address.district) &&
       apartment1.swap.list_floors.include?(apartment2.floor)
      return true
    end

    false
  end

  def self.address(apartment1, apartment2, error)
    if apartment1.address == apartment2.address
      if apartment1.number_of_floors != apartment2.number_of_floors ||
         apartment1.type_of_house != apartment2.type_of_house

        error.each_key { |key| return false if key == apartment1.address }
        return true
      end
    end

    false
  end
end
