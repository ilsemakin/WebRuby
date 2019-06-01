# frozen_string_literal: true

require 'sinatra'
require_relative 'lib/list_apartments'
require_relative 'lib/apartment'
require_relative 'lib/address'

configure do
  set :list, ListApartments.new
end

get '/add_apartment' do
  erb :apartment
end

get '/list_of_apartment' do
  @list_apartment = settings.list

  erb :list_apartment
end

post '/add_apartment' do
  @apartment = Apartment.new(params['footage'], params['rooms'],
                             Address.new(params['district'], params['street'], params['house']),
                             params['floor'], params['type_of_house'], params['number_of_floors'], params['cost'])

  @errors = @apartment.check_fields

  if @errors.empty?
    settings.list.add_apartment(@apartment)
    redirect to('/list_of_apartment')
  else
    erb :apartment
  end
end
