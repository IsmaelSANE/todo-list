module Menu
  def menu
    " Welcome to the TodoList Program!
    Please press the key 1 if you want to ADD a list.
    Please press the key 2 if you want to SHOW a list.
    Please press the key 3 if you want to UPDATE a list.
    Please press the key 4 if you want to READ a list.
    Please press the key 5 if you want to WRITE a list.
    Please press the key 6 if you want to DELETE a list.
    Please press the key 7 if you want to TOGGLE a Status.
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

  attr_reader :all_tasks

  def initialize
    @all_tasks = []
  end

  def add(task)
    all_tasks << task
  end

  def show
    all_tasks.map.with_index { |l, i| "(#{i.next}): #{l}"}
  end

  def write_to_file(filename)
    machinified = @all_tasks.map(&:to_machine).join("\n")
    IO.write(filename, machinified)
  end

  def read_for_file(filename)
    IO.readlines(filename).each do |line|
      status, *description = line.split(':')
      status = status.include?('X')
      add(Task.new(description.join(':').strip, status))
    end
  end

  def delete(task_number)
    all_tasks.delete_at(task_number - 1)
  end

  def update(task_number, task)
    all_tasks[task_number - 1] = task
  end

  def  to_machine
    "#{represent_status}: #{description}"
  end

  def toggle_status
    @completed_status = !completed?
  end
end

class Task

  attr_reader :description
  attr_accessor :status

  def initialize(description, status= false)
    @description = description
    @status = status
  end

  def to_s
    @description
  end

  def completed?
    @status
  end

  def toggle(task_number)
    @all_tasks[task_number - 1].toggle_status
  end

  private
  def represent_status
    "#{completed? ? '[X]' : '[ ]'}"
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
    when '3'
      actual_list.update(prompt('Which task to update?').to_i,
      Task.new(prompt('Task Description?')))
    when '4'
      begin
        actual_list.read_for_file(prompt('Please enter a filename'))
      rescue Errno::ENOENT
        puts 'File name not found, please verify your file name and path.'
      end
    when '5'
      actual_list.write_to_file(prompt('Please enter a filename'))
    when '6'
      puts actual_list.show
      actual_list.delete(prompt('Which task to delete?').to_i)
    when '7'
      puts actual_list.show
      actual_list.toggle(prompt('Which would you like to toggle the status for?').to_i)
    else
      puts "Sorry, I did not understand"
    end
     prompt('Press enter to continue', '')
  end
  puts "Outro - Thanks for using the menu system!"
end
