class AddIddsAndIcToTownHall < ActiveRecord::Migration
  def change
    add_column :town_halls, :idds, :string
    add_column :town_halls, :ic, :string
  end
end
