class CreateCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :categories do |t|

      t.string :name, null: false, default: ""


      t.string :description

      # color: green ou red
      t.string :color


      t.integer :kind, null: false, default: 0


      t.timestamps null: false
    end


    add_index :categories, :name, unique: true
  end
end