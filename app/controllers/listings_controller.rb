class ListingsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :set_listing, only: [:show, :edit, :update, :destroy]

	def index #---move to pages controller
		@listings = Listing.all
	end

	def new
		@listing = Listing.new
	end

	def create
		@listing = current_user.listings.create(listing_params)
		if @listing.save
			redirect_to listings_path(@listings)
		else
			render :end
		end
	end

	def show		
	end

	def edit
	end

	def update
		@listing.update(listing_params)
		if @listing.save
			redirect_to listing_path(@listing)
		else
			render :edit
		end
	end

	def destroy		
		@listing.destroy
		# redirect_to listings_path(@listings)
		redirect_to root_path
	end

	private
		def set_listing
			@listing = Listing.find(params[:id])
		end

	def listing_params
		params.require(:listing).permit(:title, :description, :property_type, :location, :price, :rooms, :capacity, :available, photos: [])
	end
end