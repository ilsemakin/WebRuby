# frozen_string_literal: true

require 'pstore'
require_relative 'input'
require_relative 'mark'
require_relative 'diary'

# scan commands
class Core
  include Input
  def initialize
    @store = PStore.new('../data/data_base.pstore')
    @diary = Diary.new
    @commands = { 0 => :help, 1 => :add, 2 => :show_diary, 100 => :exit }

    read if File.exist?('../data/data_base.pstore') && !File.zero?('../data/data_base.pstore')
    help

    at_exit do
      save
    end
  end

  def start
    loop do
      send(Input.command(@commands))
    end
  end

  def add
    name_course = Input.string('Input course name: ')
    task = Input.string('Input task: ')
    mark = Input.number('Input mark: ')

    new_mark = Mark.new(name_course, task, mark)
    @diary.add_mark(new_mark)
  end

  def show_diary
    show(@diary.show_diary)
  end

  def show(list)
    if list.empty?
      puts 'List empty!'
    else
      puts list
    end
  end

  def read
    @store.transaction(true) do
      diary = @store[:diary]
      @diary = diary if diary
    end
  end

  def save
    @store.transaction do
      @store[:diary] = @diary
    end
  end

  def help
    @commands.each { |key, command| puts "#{key} - #{command}" }
  end
end
