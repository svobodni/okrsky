class AddPasswordToRegion < ActiveRecord::Migration[4.2]
  def change
    add_column :regions, :password, :string
 	Region.all.each { |r|
 	  r.update_attribute :password, SecureRandom.urlsafe_base64(6)
 	}
  end
end
