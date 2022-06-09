class AddTodolistidToTodos < ActiveRecord::Migration[7.0]
  def change
    add_column :todos, :todolist_id, :integer
  end
end
