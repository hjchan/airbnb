class ReservationJob < ApplicationJob
  queue_as :default

  def perform(customer, host, reservation_id)
      ReservationMailer.booking_email(customer, host, reservation_id).deliver_later
  end
end
