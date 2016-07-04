class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name, null: false, unique: true
      t.string :source, null: false
      t.string :current
      t.string :scheme_type, null: false
      t.string :scheme
      t.timestamps null: false
    end
    add_index :resources, :name
  end
end
