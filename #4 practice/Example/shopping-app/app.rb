require 'sinatra'

require_relative 'lib/entry_list'
require_relative 'lib/shop_entry'
require_relative 'lib/user'

configure do
  enable :sessions
  set :available_items, EntryList.new([
    ShopEntry.new('Шапка', 600, 15),
    ShopEntry.new('Пальто', 5600, 5),
    ShopEntry.new('Рубашка', 2000, 10)
  ])
  set :shopping_carts, Hash.new { |hash, key| hash[key] = EntryList.new }
  set :session_secret, "3598f4a7f12cc6181c49bb252663c075b650f4a316df4040a8efac669f98530e30633a04a4ad84b218c639a60f08794bd28e73d3908dc41cefc15bcfb01eb09d"
  set :user_list, {}
end

get '/' do
  @available_items = settings.available_items
  erb :main
end

get '/shopping_cart/add/:item_id' do |item_id|
  session_id = session[:session_id]
  shopping_cart = settings.shopping_carts[session_id]
  available_items = settings.available_items

  if available_items.has_entry?(item_id)
    item_to_add = available_items.get_entry(item_id)
    shopping_cart.add_entry(item_to_add)
    redirect to('/shopping_cart')
  else
    404
  end
end

get '/shopping_cart/del/:item_id' do |item_id|
  session_id = session[:session_id]
  shopping_cart = settings.shopping_carts[session_id]
  shopping_cart.remove_entry(item_id)
  redirect to('/shopping_cart')
end

get '/shopping_cart' do
  session_id = session[:session_id]
  @shopping_cart = settings.shopping_carts[session_id]
  erb :shopping_cart
end

before do
  user_id = session[:user_id]
  @user = settings.user_list[user_id]
end

get '/login' do
  @user = nil
  erb :login_form
end

post '/login' do
  name = params['user']
  password = params['password']
  users = settings.user_list

  users.each_pair do |user_id, user|
    if user.name == name && user.password == password
      session[:user_id] = user_id
      redirect to('/')
    end
  end
  @errors = 'Такая пара имени пользователя и пароля не найдены'
  @user = nil
  erb :login_form
end

get '/user/new' do
  @user = nil
  erb :user_form
end

post '/user/new' do
  logger.info(params)
  user = User.new(params['user'], params['password'], params['address'])
  settings.user_list[user.id] = user
  redirect to('/')
end
