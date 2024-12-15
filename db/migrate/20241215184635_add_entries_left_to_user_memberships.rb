class AddEntriesLeftToUserMemberships < ActiveRecord::Migration[8.0]
  def change
    add_column :user_memberships, :entries_left, :integer, default: 0, null: false
  end
end
