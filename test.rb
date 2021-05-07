require "sqlite3"
DB = SQLite3::Database.new("tasks.db")
DB.results_as_hash = true
require_relative 'task'

# CRUD
# CREATE

new_task = Task.new(title: "F**k ruby", description: "f**k that typo")
# new_task.id -> nil
new_task.save

# READ (one)

# task = Task.find(8)
# # p task.title
# # p task.description
# new_task.title = "Just kidding, still love u"
# new_task.save

# UPDATE

# another_task = Task.new(title: "Do laudry", description: "Do all laudry")
# another_task.save
# another_task.title = "My Flashcards"
# another_task.save
# p another_task

# DELETE

# to_delete = Task.find(8)
# to_delete.destroy

# READ (ALL)

tasks = Task.all
tasks.each_with_index do |task, index|
  status = task.done ? "X" : " "
  puts "#{index + 1} [#{status}]- #{task.title} - #{task.description}"
end
