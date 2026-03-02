class AddNameAndRoleToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :name, :string, null: false, default: ""
    add_column :users, :role, :integer, null: false, default: 1 # 1 = member, 0 = admin

    # Index for quick lookups by role (e.g., find all admins)
    add_index :users, :role
  end
end
