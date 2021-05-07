
class Task

  attr_accessor :title, :description
  attr_reader :done

  def initialize(attr = {})
    @id          = attr[:id]
    @title       = attr[:title]
    @description = attr[:description]
    @done        = attr[:done] || false
  end


  def self.all
    records = DB.execute("SELECT * FROM tasks")
    records.map do |record|
      build_task(record)
    end
  end


  def self.find(id)
    record = DB.execute("SELECT * FROM tasks
     WHERE id = ?", id).first
    build_task(record)
  end


  def save
    @id ? update : create
  end


  def destroy
    DB.execute("DELETE FROM tasks WHERE id = ?", @id)
  end


  private

  def update
    DB.execute("UPDATE tasks
      SET title = ?, description = ?, done = ?
      WHERE id = ?", @title, @description, (@done ? 1 : 0), @id)
  end

  def create
    DB.execute("INSERT INTO
      tasks (title, description, done)
      VALUES (?, ?, ?)", @title, @description, (@done ? 1 : 0))
    @id = DB.last_insert_row_id
  end

  def self.build_task(record)
    Task.new(
     id: record["id"],
     title: record["title"],
     description: record["description"],
     done: record["done"] == 1
     )
  end

end


# class Talk
#   def print_hello
#     puts "hello"
#   end


#   def hello_and_bye
#     print_hello
#     puts "bye"
#   end
# end

# talk = Talk.new
# talk.print_hello
# talk.hello_and_bye
