class ReservationsController < ApplicationController
  def create
    date = params[:reservation][:date].partition(' to ')
    params[:reservation][:start_date] = date[0]
    params[:reservation][:end_date] = date[2]
    listing = Listing.find(params[:listing_id])
    reservation = listing.reservations.new(reservation_params)
    reservation.user_id = current_user.id
    if reservation.save
      redirect_to  user_listing_path(listing.user, listing)
    else
      flash[:notice] = reservation.errors.messages
      redirect_to  user_listing_path(listing.user, listing)
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date)
  end
end
