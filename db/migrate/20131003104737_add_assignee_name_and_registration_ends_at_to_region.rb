class AddAssigneeNameAndRegistrationEndsAtToRegion < ActiveRecord::Migration
  def change
    add_column :regions, :assignee_name, :string
    add_column :regions, :registration_ends_at, :datetime
  end
end
