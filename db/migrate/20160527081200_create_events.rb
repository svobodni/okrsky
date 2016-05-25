class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :uuid
      t.string :name
      t.string :requestor_type
      t.integer :requestor_id
      t.string :eventable_type
      t.integer :eventable_id
      t.string :command
      t.text :metadata
      t.text :data

      t.timestamps null: false
    end
  end
end
