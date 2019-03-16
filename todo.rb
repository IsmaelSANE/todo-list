module Menu
  def menu
    " Welcome to the TodoList Program!
    Please press the key 1 if you want to ADD a list.
    Please press the key 2 if you want to SHOW a list.
    Please press the key Q if you want to QUIT the program"
  end
  def show
    menu
  end
end

module Promptable
  def prompt(message='What would you like to do?', symbol=':> ')
    print message
    print symbol
    gets.chomp
  end
end

class List

  attr_reader :description, :all_tasks

  def initialize
    @all_tasks = []
  end

  def add(task)
    all_tasks << task
  end

  def show
    all_tasks.to_s
  end
end

class Task

  def initialize(description)
    @description = description
  end
end

if __FILE__ == $PROGRAM_NAME
  include Menu
  include Promptable
  actual_list = List.new
  puts 'Please choose from the following list'
  until ['q'].include?(user_input = prompt(show).downcase)
    case user_input
    when '1'
      actual_list.add(Task.new(prompt('What is the task you would
      like to accomplish?')))
      puts "You have added a new task to the Todo List"
    when '2'
      puts actual_list.show
    else
      puts "Sorry, I did not understand"
    end
  end
  puts "Outro - Thanks for using the menu system!"
end
