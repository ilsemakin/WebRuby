# frozen_string_literal: true

require 'sinatra'
require 'sqlite3'
require 'date'

FILE = 'data/DB.db'

if File.exist?(FILE)
  open_db = SQLite3::Database.open(FILE)
else
  exit
end

configure do
  set :db, open_db
  settings.db.execute 'PRAGMA foreign_keys = ON'
end

get '/' do
  erb :info
end

get '/main' do
  @db = settings.db
  erb :"/tables/deliveries"
end

get '/add/delivery' do
  @db = settings.db
  @errors = {}
  @amount = ''

  erb :"/add/delivery"
end

post '/add/delivery' do
  @db = settings.db
  @errors = {}

  @name_supplier = params['name_supplier']
  @product = params['product'].split(' за ')
  @amount = params['amount'].to_i
  @type = params['type_d']
  @date = params['date']

  name_product = @product[0]
  price = @product[1].split[0].to_f

  check_number(@errors, @amount)
  check_empty(@errors, @date)

  @type = if @type == 'Самовывоз'
            0.8
          else
            1.2
          end

  if @errors.empty?
    @db.execute 'SELECT id_supplier, name_supplier FROM Suppliers' do |row|
      @name_supplier = row[0] if @name_supplier == row[1]
    end

    @db.execute 'SELECT id_product, name_product, price FROM Goods' do |row|
      @product = row[0] if name_product == row[1] && price == row[2]
    end

    @db.execute 'INSERT INTO Deliveries (id_supplier, id_product, amount, type_delivery, date_delivery)
    VALUES (?, ?, ?, ?, ?)', [@name_supplier, @product, @amount, @type, @date]

    redirect to('/main')
  else
    erb :"/add/delivery"
  end
end

delete '/delete/delivery/:id_delivery' do
  settings.db.execute "DELETE FROM Deliveries WHERE id_delivery = '#{params['id_delivery']}'"
  redirect to('/main')
end

get '/divisions' do
  @db = settings.db
  erb :"/tables/divisions"
end

get '/add/division' do
  @db = settings.db
  @errors = {}
  @division = ''

  erb :"/add/division"
end

post '/add/division' do
  @db = settings.db
  @errors = {}
  message = 'Такая запись уже существует!'

  @division = params['add_division'].capitalize
  check_empty(@errors, @division)

  @db.execute 'SELECT name_division FROM Divisions' do |row|
    @errors.store(@division, message) if @division == row[0]
  end

  if @errors.empty?
    settings.db.execute 'INSERT INTO Divisions (name_division) VALUES (?)', @division
    redirect to('/divisions')
  else
    erb :"/add/division"
  end
end

delete '/delete/division/:id_division' do
  settings.db.execute "DELETE FROM Divisions WHERE id_division = '#{params['id_division']}'"
  redirect to('/divisions')
end

get '/products' do
  @db = settings.db
  erb :"/tables/products"
end

get '/add/type_product' do
  @db = settings.db
  @errors = {}
  @name_type_product = ''

  erb :"/add/type_product"
end

post '/add/type_product' do
  @db = settings.db
  @errors = {}
  message = 'Такая запись уже существует!'

  @name_division = params['name_division']
  @name_type_product = params['name_type_product'].capitalize

  check_empty(@errors, @name_type_product)

  @db.execute 'SELECT * FROM Divisions' do |row|
    @name_division = row[0] if @name_division == row[1]
  end

  @db.execute 'SELECT id_division, name_type_product FROM Products' do |row|
    @errors.store(@name_type_product, message) if @name_division == row[0] && @name_type_product == row[1]
  end

  if @errors.empty?
    @db.execute 'INSERT INTO Products (id_division, name_type_product)
                  VALUES (?, ?)', [@name_division, @name_type_product]
    redirect to('/products')
  else
    erb :"/add/type_product"
  end
end

delete '/delete/type_product/:id_type_product' do
  settings.db.execute "DELETE FROM Products WHERE id_type_product = '#{params['id_type_product']}'"
  redirect to('/products')
end

get '/goods' do
  @db = settings.db
  erb :"/tables/goods"
end

get '/add/product' do
  @db = settings.db
  @errors = {}

  @name_product = ''
  @price = ''

  erb :"/add/product"
end

post '/add/product' do
  @db = settings.db
  @errors = {}
  message = 'Такая запись уже существует!'

  @name_type_product = params['name_type_product']
  @name_product = params['name_product'].capitalize
  @price = params['price'].to_f

  check_empty(@errors, @name_product)
  check_number(@errors, @price)

  @db.execute 'SELECT id_type_product, name_type_product FROM Products' do |row|
    @name_type_product = row[0] if @name_type_product == row[1]
  end

  @db.execute 'SELECT id_type_product, name_product, price FROM Goods' do |row|
    @errors.store(@name_product, message) if @name_type_product == row[0] && @name_product == row[1] && @price == row[2]
  end

  if @errors.empty?
    @db.execute 'INSERT INTO Goods (id_type_product, name_product, price)
                  VALUES (?, ?, ?)', [@name_type_product, @name_product, @price]
    redirect to('/goods')
  else
    erb :"/add/product"
  end
end

delete '/delete/product/:id_product' do
  settings.db.execute "DELETE FROM Goods WHERE id_product = '#{params['id_product']}'"
  redirect to('/goods')
end

get '/suppliers' do
  @db = settings.db
  erb :"/tables/suppliers"
end

get '/supplier/:name_supplier' do
  @db = settings.db
  @supplier = params['name_supplier'].capitalize

  erb :info_supplier
end

get '/add/supplier' do
  @db = settings.db
  @errors = {}

  @name_supplier = ''
  @address_supplier = ''
  @phone_supplier = ''

  erb :"/add/supplier"
end

post '/add/supplier' do
  @db = settings.db
  @errors = {}
  message = 'Такая запись уже существует!'

  @name_supplier = params['name_supplier']
  @address_supplier = params['address_supplier']
  @phone_supplier = params['phone_supplier']

  check_empty(@errors, @name_supplier, @address_supplier, @phone_supplier)

  @db.execute 'SELECT name_supplier, address, phone FROM Suppliers' do |row|
    @errors.store(@name_supplier, message) if @name_supplier == row[0]
    @errors.store(@address_supplier, message) if @division == row[1]
    @errors.store(@phone_supplier, message) if @phone_supplier == row[2]
  end

  if @errors.empty?
    settings.db.execute 'INSERT INTO Suppliers (name_supplier, address, phone)
                          VALUES (?, ?, ?)', [@name_supplier, @address_supplier, @phone_supplier]
    redirect to('/suppliers')
  else
    erb :"/add/supplier"
  end
end

delete '/delete/supplier/:id_supplier' do
  settings.db.execute "DELETE FROM Suppliers WHERE id_supplier = '#{params['id_supplier']}'"
  redirect to('/suppliers')
end

get '/find/price' do
  @db = settings.db
  @errors = {}

  @name_product = params['name_product']

  erb :find_price
end

post '/find/price' do
  @db = settings.db
  @errors = {}

  @name_product = params['name_product'].capitalize
  check_empty(@errors, @name_product)

  erb :find_price
end

get '/find/assortment' do
  @db = settings.db
  @name_division = params['name_division']
  @name_supplier = ''

  erb :find_assortment
end

post '/find/assortment' do
  @db = settings.db
  @name_division = params['name_division']

  erb :find_assortment
end

get '/find/amount' do
  @db = settings.db
  @errors = {}

  @name_product = params['name_product']
  @amount = ''

  erb :conditions
end

post '/find/amount' do
  @db = settings.db
  @errors = {}

  @name_product = params['name_product']
  @amount = params['amount'].to_i
  check_number(@errors, @amount)

  erb :conditions
end

get '/list_supplier' do
  @db = settings.db
  @errors = {}

  @name_product1 = params['name_product1']
  @amount1 = ''

  @name_product2 = params['name_product2']
  @amount2 = ''

  @name_product3 = params['name_product3']
  @amount3 = ''

  erb :list_supplier
end

post '/list_supplier' do
  @db = settings.db
  @errors = {}

  @name_product1 = params['name_product1']
  @amount1 = params['amount1'].to_i

  @name_product2 = params['name_product2']
  @amount2 = params['amount2'].to_i

  @name_product3 = params['name_product3']
  @amount3 = params['amount3'].to_i

  check_number(@errors, @amount1)

  erb :list_supplier
end

get '/pay' do
  @db = settings.db
  @date1 = params['date1']
  @date2 = params['date2']
  @pay = params['pay']

  erb :pay
end

post '/pay' do
  @db = settings.db
  @date1 = params['date1']
  @date2 = params['date2']
  @pay = params['pay']

  erb :pay
end

get '/*' do
  erb :error
end

def check_empty(errors, *fields)
  message = 'Поле не заполнено!'
  fields.each { |field| errors.store(field, message) if field.empty? }
end

def check_number(errors, *numbers)
  message = 'Введите положительное число!'
  numbers.each { |number| errors.store(number, message) if number.zero? || number.negative? }
end
