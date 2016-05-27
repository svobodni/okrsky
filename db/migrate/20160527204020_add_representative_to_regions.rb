class AddRepresentativeToRegions < ActiveRecord::Migration
  def change
    add_column :regions, :representative_id, :integer
  end
end
