# frozen_string_literal: true

# creating address
class Address
  attr_reader :district, :street, :house

  def initialize(district, street, house)
    @district = district
    @street = street
    @house = house.to_i
  end
end
