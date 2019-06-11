# frozen_string_literal: true

require 'securerandom'
require_relative 'checks'

# creating list of apartments
class ListApartments
  include Check
  def initialize
    @list = {}
  end

  def each
    @list.each { |key, apartment| yield key, apartment }
  end

  def each_value
    @list.each_value { |apartment| yield apartment }
  end

  def empty?
    @list.empty?
  end

  def [](key)
    @list[key]
  end

  def add_apartment(apartment)
    id = SecureRandom.uuid
    @list.store(id, apartment)
  end

  def delete(key)
    @list.delete(key)
  end

  def sort_by_footage
    @list.sort_by { |_key, apartment| apartment.footage }.to_h
  end

  def sort_by_cost
    @list.sort_by { |_key, apartment| apartment.cost }.to_h
  end

  def sort_by_district
    @list.sort_by { |_key, apartment| apartment.address.district }.to_h
  end

  def find_swaps(this_apartment)
    list_swaps = {}
    @list.each do |key, apartment|
      next unless Check.swap(this_apartment, apartment) &&
                  Check.swap(apartment, this_apartment) &&
                  this_apartment != apartment

      list_swaps.store(key, apartment)
    end

    list_swaps
  end

  def find_swaps_street(this_apartment)
    list_swaps = {}
    @list.each do |key, apartment|
      next unless this_apartment.address.street == apartment.address.street &&
                  Check.swap(this_apartment, apartment) &&
                  Check.swap(apartment, this_apartment) &&
                  this_apartment != apartment

      list_swaps.store(key, apartment)
    end

    list_swaps
  end

  def no_swaps
    list_no_swaps = []
    @list.each_value do |apartment|
      list_no_swaps << apartment if find_swaps(apartment).empty?
    end

    list_no_swaps
  end

  def statistics
    statistics = {}
    districts.each do |district|
      count = 0
      swap = 0
      average = 0
      @list.each_value do |apartment|
        next unless district == apartment.address.district

        count += 1
        swap += 1 if apartment.swap.list_districts.include?(district)
        average += apartment.cost / apartment.footage
      end
      item = [count, swap, average / count]
      statistics.store(district, item)
    end

    statistics
  end

  def check_database
    error = {}
    @list.each_value do |apartment1|
      list = [apartment1]
      @list.each_value do |apartment2|
        list << apartment2 if Check.address(apartment1, apartment2, error)
      end
      error.store(apartment1.address, list) if list.size != 1
    end

    error
  end

  private

  def districts
    districts = []
    @list.each_value { |apartment| districts << apartment.address.district }

    districts.uniq
  end
end
