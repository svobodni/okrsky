class AddDeviseToCommisary < ActiveRecord::Migration[4.2]
  def change
    add_column :commisaries, :encrypted_password, :string
    add_column :commisaries, :reset_password_token, :string
    add_column :commisaries, :reset_password_sent_at, :datetime

    add_column :commisaries, :sign_in_count, :integer

    add_column :commisaries, :current_sign_in_at, :datetime
    add_column :commisaries, :last_sign_in_at, :datetime
    add_column :commisaries, :current_sign_in_ip, :string
    add_column :commisaries, :last_sign_in_ip, :string
  end
end
