class ListingsController < ApplicationController

	def index
		@listing = Listing.all
	end

	def show
		@listing = Listing.find(params[:id])
	end

	def new
		@lsting = Listing.new
	end

	def create
		params[:listing][user_id] = current_user.id
		@listing = Listing.new(listing_from_params)
		if @listing.save
			redirect_to edit_listing_path(@listing)
		else
			render template: "listing/new"
		end
	end

	def edit
		@listing = Listing.find(params[:id])
	end

	def update
		@listing = Listing.find(params[:id])
		if current_user.id = @listing.user_id
			@listing.update_attributes!(listing_from_params)
			redirect_to listing_path(@listing)
		else
			redirect_to root
		end
	end 

	def delete
		@listing = Listing.find(params[:id])
		if current_user.id = @listing.user_id
			@listing.destroy
			redirect_to user_path(current_user)
		else
			redirect_to root
		end
	end

	private

	def listing_from_params
		params.require(:listing).permit(:name, :property_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :zipcode, :price, :description, :user_id)
	end

end