class AddRegistrationAllowedToMunicipalities < ActiveRecord::Migration
  def change
    add_column :municipalities, :registration_allowed, :boolean
  end
end
