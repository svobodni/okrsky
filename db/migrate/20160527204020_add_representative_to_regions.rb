class AddRepresentativeToRegions < ActiveRecord::Migration[4.2]
  def change
    add_column :regions, :representative_id, :integer
  end
end
