# frozen_string_literal: true

require 'pstore'
require_relative 'lib/list_apartments'
require_relative 'lib/apartment'
require_relative 'lib/address'

storage = PStore.new('data/data_base.pstore')

storage.transaction(true) do
  @list = storage[:list]
  @list = ListApartments.new if !@list
end

at_exit do
  storage.transaction do
    storage[:list] = @list
  end
end

require 'sinatra'

configure do
  set :list, @list
end

get '/' do
  erb :index
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
