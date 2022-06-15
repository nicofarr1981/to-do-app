class Todos < ActiveRecord::Migration[7.0]
  def change
    create_table "todos", force: :cascade do |t|
      t.string "description"
      t.datetime "duedate"
      t.boolean "done"
      t.integer "user_id"
      t.integer "todolist_id"
    end
  end
end
