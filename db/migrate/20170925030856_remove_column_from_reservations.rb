class RemoveColumnFromReservations < ActiveRecord::Migration[5.1]
  def change
    remove_column :reservations, :prices
  end
end
