class ReservationsController < ApplicationController
  def create
    date = params[:reservation][:date].partition(' to ')
    params[:reservation][:start_date] = date[0]
    params[:reservation][:end_date] = date[2]
    listing = Listing.find(params[:listing_id])
    reservation = listing.reservations.new(reservation_params)
    reservation.user_id = current_user.id
    if reservation.save
      redirect_to  payment_user_reservation_path(reservation.user, reservation)
    else
      flash[:notice] = reservation.errors.messages
      redirect_to  user_listing_path(listing.user, listing)
    end
  end

  def index
    user = User.find(params[:user_id])
    @reservations = user.reservations
  end

  def payment
    @reservation = Reservation.find(params[:id])
    @client_token = Braintree::ClientToken.generate
    gon.clientToken = @client_token
  end

  def checkout
    reservation = Reservation.find(params[:id])
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
    result = Braintree::Transaction.sale(
     :amount => reservation.total_amount, #this is currently hardcoded
     :payment_method_nonce => nonce_from_the_client,
     :options => {
        :submit_for_settlement => true
      }
     )
    if result.success?
      reservation.update(paid_status: true)
      ReservationJob.perform_later(current_user, reservation.listing.user, params[:id])
      redirect_to :root, :flash => { :success => "Transaction successful!" }
    else
      redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
    end 
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date)
  end
end
