require 'securerandom'

class User
  attr_reader :address
  attr_reader :id
  attr_reader :name
  attr_reader :password

  def initialize(name, password, address)
    @name = name
    @password = password
    @address = address
    @id = SecureRandom.uuid
  end
end