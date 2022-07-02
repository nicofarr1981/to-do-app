class AddOwningUserToUsergroup < ActiveRecord::Migration[7.0]
  def change
    add_column :usergroups, :owning_user_id, :integer
  end
end
