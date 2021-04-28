class AddIddsAndIcToTownHall < ActiveRecord::Migration[4.2]
  def change
    add_column :town_halls, :idds, :string
    add_column :town_halls, :ic, :string
  end
end
