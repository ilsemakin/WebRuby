# frozen_string_literal: true

require 'sinatra'
require 'sinatra/json'
require 'pp'

get '/' do
  json foo: 'bar'
end

post '/' do
  raw_body = request.body.read
  puts "Raw request:\n#{raw_body}"
  json_document = JSON.parse(raw_body)
  puts "Parsed text:\n#{json_document}"
end
