# frozen_string_literal: true

# creating one flight
class Flight
  attr_reader :departure_airport, :arrival_airport, :number
  attr_reader :available_seats, :reserved_seats
  attr_reader :time_departure, :time_arrival
  attr_reader :cost

  def initialize(departure_airport, arrival_airport, number, available_seats,
                reserved_seats, time_departure, time_arrival, cost)

    @departure_airport = departure_airport
    @arrival_airport = arrival_airport
    @number = number.to_i
    @available_seats = available_seats.to_i
    @reserved_seats = reserved_seats.to_i
    @time_departure = time_departure
    @time_arrival = time_arrival
    @cost = cost.to_i
  end

  def check_field
    errors = {}

    message_empty = 'This field cannot be empty!'
    message_negative = 'Number < 0!'

    check_empty(errors, message_empty)
    check_negative(errors, message_negative)

    errors
  end

  def check_empty(errors, message)
    errors[:departure_airport] = message if @departure_airport.empty?
    errors[:arrival_airport] = message if @arrival_airport.empty?
    errors[:time_departure] = message if @time_departure.empty?
    errors[:time_arrival] = message if @time_arrival.empty?
  end

  def check_negative(errors, message)
    errors[:number] = message if @number.negative?
    errors[:available_seats] = message if @available_seats.negative?
    errors[:reserved_seats] = message if @reserved_seats.negative?
  end

  def to_s
    "Аэропорт отправления: #{@departure_airport}" \
      "\nАэропорт прибытия: #{@arrival_airport}" \
      "\nНомер рейса: #{@number}" \
      "\nКоличество доступных посадочных мест: #{@available_seats}" \
      "\nКоличество забронированных посадочных мест: #{@reserved_seats}" \
      "\nВремя вылета: #{@time_departure}" \
      "\nВремя прибытия: #{@time_arrival}" \
      "\nСтоимость билета: #{@cost}\n"
  end
end
