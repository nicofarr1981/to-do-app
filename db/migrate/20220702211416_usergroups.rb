class Usergroups < ActiveRecord::Migration[7.0]
  def change
    create_table "usergroups", force: :cascade do |t|
      t.string "name"
      t.integer "owning_user_id"
    end
  end
end
