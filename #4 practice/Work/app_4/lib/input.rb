# frozen_string_literal: true

# input data
module Input
  def self.string(message)
    loop do
      print message
      line = gets
      return nil if line.nil?
      return line.strip unless line.strip.empty?

      puts 'Line is empty! Try again!'
    end
  end

  def self.number_command(message)
    loop do
      print message
      line = gets
      return nil if line.nil?

      number = Integer(line.strip)
      return number

    rescue ArgumentError => _e
      puts 'Input error! Try again!'
    end
  end

  def self.number(message)
    loop do
      print message
      line = gets
      return nil if line.nil?

      number = Integer(line.strip)
      return number if (0..5).include?(number)

      puts 'Number less than 0 or more then 5! Try again!'
    rescue ArgumentError => _e
      puts 'Input error! Try again!'
    end
  end

  def self.command(commands)
    loop do
      id = Integer(Input.number_command("\nInput command > "))
      commands.each { |index, command| return command if id == index }
      puts 'Invalid command! Try again!'
    end
  end
end
