class ReservationMailer < ApplicationMailer

  def booking_email(customer, host, reservation_id)
    @customer = customer
    @url = "testing"
    mail(to: host.email, subject: "You have received a booking")
  end

end
