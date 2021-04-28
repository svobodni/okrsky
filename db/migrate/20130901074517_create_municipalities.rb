class CreateMunicipalities < ActiveRecord::Migration[4.2]
  def change
    create_table :municipalities do |t|
      t.string :name
      t.integer :region_id

      t.timestamps
    end
  end
end
