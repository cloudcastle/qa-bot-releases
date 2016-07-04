class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :slack_id, null: false, unique: true
      t.text :resources_ids, array: true, default: []
      t.timestamps null: false
    end
  end
end
