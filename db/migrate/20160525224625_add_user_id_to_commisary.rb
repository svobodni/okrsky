class AddUserIdToCommisary < ActiveRecord::Migration
  def change
    add_column :commisaries, :user_id, :integer
  end
end
