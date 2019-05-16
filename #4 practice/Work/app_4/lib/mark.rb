# frozen_string_literal: true

# create one mark
class Mark
  attr_reader :name_course, :task, :mark

  def initialize(name_course, task, mark)
    @name_course = name_course
    @task = task
    @mark = mark.to_i
  end

  def check_field
    errors = ['', '', '']
    message_empty = 'This field cannot be empty!'
    message_range = 'Number less than 0 or more then 5!'
    check_empty(errors, message_empty)
    check_range(errors, message_range)

    errors
  end

  def check_empty(errors, message)
    errors[0] = message if @name_course.empty?
    errors[1] = message if @task.empty?
  end

  def check_range(errors, message)
    errors[2] = message unless (0..5).include?(@mark)
  end

  def to_s
    "Курс: #{@name_course} | Задача: #{@task} | Оценка: #{@mark}"
  end
end
