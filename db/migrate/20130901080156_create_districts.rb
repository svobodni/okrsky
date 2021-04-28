class CreateDistricts < ActiveRecord::Migration[4.2]
  def change
    create_table :districts do |t|
      t.string :name
      t.integer :municipality_id

      t.timestamps
    end
  end
end
