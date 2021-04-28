class AddUserIdToCommisary < ActiveRecord::Migration[4.2]
  def change
    add_column :commisaries, :user_id, :integer
  end
end
