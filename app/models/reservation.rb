class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :check_overlapping_dates, on: :create

  before_save :total_amount_calculate

  def check_overlapping_dates
    listing.reservations.each do |old_booking|
      if (old_booking.id)
        if overlap?(self, old_booking)
          return errors.add(:check_overlapping_dates, "The booking dates conflict with existing booking")
        end
      end
    end
  end

  private

  def overlap?(x, y)
    (x.start_date - y.end_date) * (y.start_date - x.end_date) > 0
  end

  def total_amount_calculate
    self.total_amount = (self.end_date - self.start_date) * self.listing.price
  end

end
