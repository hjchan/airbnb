class CreateAuthorization < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :role, :integer, default: 0
    add_column :listings, :verify, :boolean, default: false
  end
end
