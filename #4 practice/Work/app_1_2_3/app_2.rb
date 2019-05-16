# frozen_string_literal: true

my_core_data = 'Изначальное значение'

at_exit do
  puts my_core_data
  my_core_data = 'Значение из первого обработчика'
end

at_exit do
  puts my_core_data
  my_core_data = 'Второй обработчик был тут'
end

puts "Значение переменой в коде приложения: #{my_core_data}"

exit
