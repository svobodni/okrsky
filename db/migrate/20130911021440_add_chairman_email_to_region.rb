class AddChairmanEmailToRegion < ActiveRecord::Migration[4.2]
  def change
    add_column :regions, :chairman_email, :string
  end
end
