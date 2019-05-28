# frozen_string_literal: true

# creating list of flight
class ListFlight
  def initialize
    @list = []
  end

  def add(flight)
    @list << flight
  end

  def each
    @list.each { |flight| yield flight }
  end
end
