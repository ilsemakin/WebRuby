# frozen_string_literal: true

require 'sinatra'
require_relative 'lib/list_triangles'
require_relative 'lib/triangle'

configure do
  set :triangles, ListTriangles.new
end

get '/' do
  erb :index
end

get '/triangles/new' do
  @triangle = Triangle.new(0, 0, 0)
  erb :triangle_new
end

get '/triangles' do
  @triangles = settings.triangles
  erb :triangles
end

get '/about' do
  erb :about
end

post '/triangles/new' do
  @triangle = Triangle.new(params['Side_A'], params['Side_B'], params['Side_C'])
  @errors = @triangle.check_field

  tmp = @errors.reject { |er| er == '' }
  if tmp.empty?
    settings.triangles.add_triangle(@triangle)
    redirect to('/triangles')
  else
    erb :triangle_new
  end
end
