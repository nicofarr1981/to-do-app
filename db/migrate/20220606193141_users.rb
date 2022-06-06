class Users < ActiveRecord::Migration[7.0]
  def change
    create_table "users", force: :cascade do |t|
      t.string "first_name"
      t.string "last_name"
      t.string "email"
      t.string "password"
    end
  end
end
