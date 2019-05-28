# frozen_string_literal: true

require 'pstore'
require_relative 'lib/flight'
require_relative 'lib/list_flight'

storage = PStore.new('data/data_base.pstore')

storage.transaction(true) do
  @flights = storage[:flights]
  @flights = ListFlight.new if !@flights
end

at_exit do
  storage.transaction do
    storage[:flights] = @flights
  end
end

require 'sinatra'

configure do
  set :flights, @flights
end

get '/flight' do
  @flight = Flight.new('', '', 0, 0, 0, '', '', 0)
  erb :flight
end

get '/flights' do
  @flights = settings.flights
  erb :flights
end

post '/flight' do
  @flight = Flight.new(params['departure_airport'], params['arrival_airport'], params['number'],
                       params['available_seats'], params['reserved_seats'], params['time_departure'],
                       params['time_arrival'], params['cost'])

  @errors = @flight.check_field

  if @errors.empty?
    settings.flights.add(@flight)
    redirect to('/flights')
  else
    erb :flight
  end
end
