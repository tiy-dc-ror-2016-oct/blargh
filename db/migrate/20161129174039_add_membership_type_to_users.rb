class AddMembershipTypeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :membership_type, :string
  end
end
