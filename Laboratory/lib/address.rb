# frozen_string_literal: true

# creating address
class Address
  include Comparable
  attr_reader :district, :street, :house

  def initialize(district, street, house)
    @district = district
    @street = street
    @house = house
  end

  def ==(other)
    @district == other.district &&
      @street == other.street &&
      @house == other.house
  end

  def to_s
    str = "\n\tDistrict: #{@district}" \
          "\n\tStreet: #{@street}" \
          "\n\tHouse: #{@house}"
    str
  end
end
