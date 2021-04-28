class AddWardIdToCommisary < ActiveRecord::Migration[4.2]
  def change
    add_column :commisaries, :ward_id, :integer
  end
end
