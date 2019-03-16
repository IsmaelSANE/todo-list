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
  my_list = List.new
  puts 'You have created a new list'
  puts "What's the name of the task?"
  task = gets.chomp
  my_list.add(Task.new(task))
  puts "You have added #{task} to the Todo List"
  puts my_list.show
end
