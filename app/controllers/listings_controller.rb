class ListingsController < ApplicationController

  # GET    /listings(.:format)  
  # GET    /users/:user_id/listings(.:format)
	def index
    if params[:user_id]
      user = User.find(params[:user_id])
      @listings = user.listings
    else
  		@listings = Listing.where(verify: true)
    end
	end

  # GET    /users/:user_id/listings/:id(.:format) 
	def show
    user = User.find(params[:user_id])
		@listing = user.listings.find(params[:id])
    @reservation = @listing.reservations.new
    reservations = Reservation.where(listing_id: params[:id]).map{|x| {from: x.start_date, to: x.end_date.prev_day}}
    gon.reservations = reservations
	end

  # GET    /users/:user_id/listings/new(.:format)   
	def new
    if signed_in?
		  @listing = current_user.listings.new
    else
      flash[:notice] = "Please sign in before create listing."
      redirect_to sign_in_path
    end
	end

  # POST   /users/:user_id/listings(.:format) 
	def create
		@listing = current_user.listings.new(listing_from_params)
		if @listing.save
			redirect_to user_listing_path(current_user, @listing)
		else
			render "new"
		end
	end

  # GET    /users/:user_id/listings/:id/edit(.:format)
	def edit
    if signed_in? && (current_user.id == params[:user_id].to_i)
  		@listing = current_user.listings.find(params[:id])
    else
      flash[:notice] = "Please sign in before edit listing."
      redirect_to sign_in_path
    end
	end

  # PATCH  /users/:user_id/listings/:id(.:format) 
	def update
		@listing = current_user.listings.find(params[:id])
		if current_user.id = @listing.user_id
			@listing.update_attributes!(listing_from_params)
			redirect_to user_listing_path(current_user, @listing)
		else
			redirect_to root
		end
	end 

  # DELETE /users/:user_id/listings/:id(.:format)  
	def destroy
    @listing = Listing.find(params[:id])
		if (current_user.id = @listing.user_id) || current_user.admin?
			@listing.destroy
      if current_user.admin?
        redirect_to admin_verify_path		 
      else
        redirect_to user_listing_path(current_user, @listing)
      end
		else
			redirect_to root
		end
	end

	private

	def listing_from_params
		params.require(:listing).permit(:name, :property_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :zipcode, :address, :price, :description, :user_id, {pictures: []})
	end

end