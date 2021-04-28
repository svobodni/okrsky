class CreateTownHalls < ActiveRecord::Migration[4.2]
  def change
    create_table :town_halls do |t|
      t.string :type
      t.string :name
      t.string :address
      t.integer :wards_count
      t.string :wards_list_uri
      t.integer :municipality_id
      t.integer :district_id

      t.timestamps
    end
  end
end
