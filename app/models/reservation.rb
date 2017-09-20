class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  validates :start_date, presence: true
  validates :end_date, presence: true
  # validates :check_overlapping_dates

  # def check_overlapping_dates
  #   listing.bookings.each do |old_booking|

  #   end
  # end

end
