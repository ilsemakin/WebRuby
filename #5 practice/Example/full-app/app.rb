# frozen_string_literal: true

require 'sinatra'

configure do
  set :marks, []
end

configure :test do
  set :marks, [
    { name: 'Русский язык', value: 5 },
    { name: 'Физика', value: 3 }
  ]
end

get '/' do
  @marks = settings.marks
  erb :main
end

get '/new' do
  @mark = { name: '', value: '' }
  erb :test_form
end

post '/new' do
  @mark = { name: params['name'], value: params['mark'] }
  @errors = []
  @errors.append('Имя не может быть пустым') if @mark[:name].empty?
  @errors.append('Оценка не может быть пустой') if @mark[:value].empty?
  if @errors.empty?
    settings.marks.append(@mark)
    redirect to('/')
  else
    erb :test_form
  end
end

get '/edit/:mark_id' do |mark_id|
  @mark = settings.marks[mark_id.to_i]
  erb :test_form
end

post '/edit/:mark_id' do |mark_id|
  @mark = { name: params['name'], value: params['mark'] }
  @errors = []
  @errors.append('Имя не может быть пустым') if @mark[:name].empty?
  @errors.append('Оценка не может быть пустой') if @mark[:value].empty?
  if @errors.empty?
    settings.marks[mark_id.to_i] = @mark
    redirect to('/')
  else
    erb :test_form
  end
end
