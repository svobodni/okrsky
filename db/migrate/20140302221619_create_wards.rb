class CreateWards < ActiveRecord::Migration[4.2]
  def change
    create_table :wards do |t|
      t.integer :external_id
      t.integer :municipality_id
      t.integer :district_id

      t.timestamps
    end
  end
end
