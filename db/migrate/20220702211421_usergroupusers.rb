class Usergroupusers < ActiveRecord::Migration[7.0]
  def change
    create_table "usergroupusers", force: :cascade do |t|
      t.integer "usergroup_id"
      t.integer "user_id"
    end
  end
end
