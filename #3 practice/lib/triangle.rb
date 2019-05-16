# frozen_string_literal: true

# creating one triangle
class Triangle
  attr_reader :side_a, :side_b, :side_c

  def initialize(side_a, side_b, side_c)
    @side_a = Float(side_a)
    @side_b = Float(side_b)
    @side_c = Float(side_c)
  end

  def triangle?
    return true if (@side_b + @side_c) > @side_a && (@side_a + @side_c) > @side_b && (@side_a + @side_b) > @side_c

    false
  end

  def area
    if triangle?
      t = (@side_a + @side_b + @side_c) / 2
      return Math.sqrt(t * (t - @side_a) * (t - @side_b) * (t - @side_c)).round(3)
    end

    0
  end

  def check_field
    errors = ['', '', '']
    message = 'This field cannot be empty or contain zero!'
    check_empty_zero(errors, message)

    errors
  end

  def check_empty_zero(errors, message)
    errors[0] = message if @side_a.to_s.to_i.zero?
    errors[1] = message if @side_b.to_s.to_i.zero?
    errors[2] = message if @side_c.to_s.to_i.zero?
  end

  def to_s
    "A=#{@side_a} B=#{@side_b} C=#{@side_c}"
  end
end
