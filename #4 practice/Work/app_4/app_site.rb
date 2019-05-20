# frozen_string_literal: true

require 'pstore'
require_relative 'lib/mark'
require_relative 'lib/diary'

store = PStore.new('data/data_base.pstore')

store.transaction(true) do
  @diary = store[:diary]
  @diary = Diary.new if !@diary
end

at_exit do
  store.transaction do
    store[:diary] = @diary
  end
end

require 'sinatra'

configure do
  set :diary, @diary
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

  if @errors.empty?
    settings.diary.add_mark(@mark)
    redirect to('/diary')
  else
    erb :mark
  end
end
