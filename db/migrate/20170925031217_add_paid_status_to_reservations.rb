class AddPaidStatusToReservations < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :paid_status, :boolean, default: false
  end
end
