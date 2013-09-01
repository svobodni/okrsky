class CreateCommisaries < ActiveRecord::Migration
  def change
    create_table :commisaries do |t|
      t.string :name
      t.string :birth_number
      t.string :address
      t.string :postal_address
      t.string :phone
      t.string :email
      t.integer :town_hall_id
      t.string :ward_number

      t.timestamps
    end
  end
end
