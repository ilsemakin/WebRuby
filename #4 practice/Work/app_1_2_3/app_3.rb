# frozen_string_literal: true

consol_read_data = ''

at_exit do
  puts consol_read_data
end

at_exit do
  consol_read_data = ARGV
end

exit
