class AddChairmanEmailToRegion < ActiveRecord::Migration
  def change
    add_column :regions, :chairman_email, :string
  end
end
