# frozen_string_literal: true

require_relative 'lib/list_apartments'
require_relative 'lib/apartment'
require_relative 'lib/address'
require_relative 'lib/swap'
require 'pstore'

storage_apartments = PStore.new('data/data_base_apartments.pstore')

storage_apartments.transaction(true) do
  @list_apartments = storage_apartments[:list_apartments]
  @list_apartments = ListApartments.new if !@list_apartments
end

at_exit do
  storage_apartments.transaction do
    storage_apartments[:list_apartments] = @list_apartments
  end
end

require 'sinatra'

configure do
  set :list_apartments, @list_apartments
end

get '/' do
  erb :index
end

get '/add_apartment' do
  @apartment = Apartment.new('', '', Address.new('', '', ''), '', '', '', '',
                             Swap.new(Range.new('', ''), Range.new('', ''), [], [], Range.new('', '')))
  erb :apartment
end

post '/add_apartment' do
  swap = Swap.new(Range.new(params['range_footage_first'].to_i, params['range_footage_end'].to_i),
                  Range.new(params['range_rooms_first'].to_i, params['range_rooms_end'].to_i),
                  params['list_districts'].split(' '), params['list_floors'].split(' ').map(&:to_i),
                  Range.new(params['range_cost_first'].to_i, params['range_cost_end'].to_i))

  @apartment = Apartment.new(params['footage'].to_i, params['rooms'].to_i,
                             Address.new(params['district'], params['street'], params['house'].to_i),
                             params['floor'].to_i, params['type_of_house'], params['number_of_floors'].to_i,
                             params['cost'].to_i, swap)

  @errors_apartment = @apartment.check_fields
  @errors_swap = swap.check_fields

  if @errors_apartment.empty? && @errors_swap.empty?
    settings.list_apartments.add_apartment(@apartment)
    redirect to('/list_of_apartments')
  else
    erb :apartment
  end
end

post '/delete_apartment/:id' do
  settings.list_apartments.delete(params['id'])
  redirect to('/list_of_apartments')
end

get '/list_of_apartments' do
  @list_apartments = settings.list_apartments
  erb :list_apartments
end

get '/list_of_apartments/district' do
  @list_apartments = settings.list_apartments.sort_by_district
  erb :list_apartments
end

get '/list_of_apartments/cost' do
  @list_apartments = settings.list_apartments.sort_by_cost
  erb :list_apartments
end

get '/list_of_apartments/footage' do
  @list_apartments = settings.list_apartments.sort_by_footage
  erb :list_apartments
end

post '/find_swaps/:id' do
  apartment = settings.list_apartments[params['id']]
  @cost = apartment.cost
  @list_swaps = settings.list_apartments.find_swaps(apartment)
  erb :list_swaps
end

post '/find_swaps_street/:id' do
  apartment = settings.list_apartments[params['id']]
  @cost = apartment.cost
  @list_swaps = settings.list_apartments.find_swaps_street(apartment)
  erb :list_swaps
end

post '/save_and_delete_apartment/:id' do
  File.write('data/swaps.txt', settings.list_apartments[params['id']], mode: 'a')
  settings.list_apartments.delete(params['id'])
  redirect to('/list_of_apartments')
end

get '/no_swaps' do
  if settings.list_apartments.empty?
    redirect to('/list_of_apartments')
  else
    @list_no_swaps = settings.list_apartments.no_swaps
    erb :list_no_swaps
  end
end

get '/statistics' do
  if settings.list_apartments.empty?
    redirect to('/list_of_apartments')
  else
    @statistics = settings.list_apartments.statistics
    erb :statistics
  end
end

get '/check_database' do
  if settings.list_apartments.empty?
    redirect to('/list_of_apartments')
  else
    @database = settings.list_apartments.check_database
    erb :database
  end
end
