# frozen_string_literal: true

# create list of marks
class Diary
  def initialize
    @list_mark = []
  end

  def add_mark(mark)
    @list_mark << mark
  end

  def show_diary
    list = []
    @list_mark.each { |mark| list << mark }
    list
  end

  def each
    @list_mark.each { |mark| yield mark }
  end
end
