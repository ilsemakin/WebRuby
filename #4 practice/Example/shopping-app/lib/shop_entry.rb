require 'securerandom'

class ShopEntry
  attr_reader :amount
  attr_reader :id
  attr_reader :name
  attr_reader :price

  def initialize(name, price, amount)
    @name = name
    @price = price
    @amount = amount
    @id = SecureRandom.uuid
  end
end
