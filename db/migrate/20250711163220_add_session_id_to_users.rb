class AddSessionIdToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :session_id, :string
  end
end
