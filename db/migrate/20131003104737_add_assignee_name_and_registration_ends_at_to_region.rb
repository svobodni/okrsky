class AddAssigneeNameAndRegistrationEndsAtToRegion < ActiveRecord::Migration[4.2]
  def change
    add_column :regions, :assignee_name, :string
    add_column :regions, :registration_ends_at, :datetime
  end
end
