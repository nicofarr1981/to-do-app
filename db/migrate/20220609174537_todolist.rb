class Todolist < ActiveRecord::Migration[7.0]
  def change
    create_table "todolists", force: :cascade do |t|
      t.string "title"
      t.integer "user_id"
    end
  end
end
