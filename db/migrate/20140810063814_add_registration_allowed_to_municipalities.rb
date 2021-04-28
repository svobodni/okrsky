class AddRegistrationAllowedToMunicipalities < ActiveRecord::Migration[4.2]
  def change
    add_column :municipalities, :registration_allowed, :boolean
  end
end
