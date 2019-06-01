# frozen_string_literal: true

require 'net/http'
require 'json'
require 'pp'

def app_url(path = '')
  URI("http://localhost:4567/#{path}")
end

def request_data
  puts 'Sending GET-request'
  response = Net::HTTP.get(app_url('/'))
  puts "Got response: \n#{response}"
end

def send_data_to_server
  puts 'Sending POST-request'
  uri = app_url('/')
  request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
  request.body = { param1: 'some value', param2: 'some other value' }.to_json
  response = Net::HTTP.start(uri.hostname, uri.port) do |http|
    http.request(request)
  end
  puts "Got response:\n#{response}"
end

def main
  request_data
  send_data_to_server
end

main if $PROGRAM_NAME == __FILE__
