class AddWardIdToCommisary < ActiveRecord::Migration
  def change
    add_column :commisaries, :ward_id, :integer
  end
end
