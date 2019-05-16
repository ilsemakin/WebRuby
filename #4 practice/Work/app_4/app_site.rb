# frozen_string_literal: true

require 'sinatra'
require_relative 'lib/mark'
require_relative 'lib/diary'

configure do
    set :diary, Diary.new
end

get '/' do
  erb :index
end

get '/mark' do
  @mark = Mark.new('', '', 0)
  erb :mark
end

get '/diary' do
  @diary = settings.diary
  erb :diary
end

post '/mark' do
  @mark = Mark.new(params['name_course'], params['task'], params['mark'])
  @errors = @mark.check_field

  tmp = @errors.reject { |er| er == '' }
  if tmp.empty?
    settings.diary.add_mark(@mark)
    redirect to('/diary')
  else
    erb :mark
  end
end
