class ListingsController < ApplicationController
	def index
		@listings = Listing.all
	end

	def new
		@listing = Listing.new
	end

	def create
		@listing = current_user.listings.create(title: params[:listing][:title])
		if @listing.save
			redirect_to listings_path(@listings)
		else
			render :end
		end
	end

	def show
		@listing = Listing.find(params[:id])
	end

	def edit
		@listing = Listing.find(params[:id])
	end

	def update
		@listing = Listing.find(params[:id])
		@listing.update(title: params[:listing][:title])
		if @listing.save
			redirect_to listing_path(@listing)
		else
			render :edit
		end
	end

	def destroy
		@listing = Listing.find(params[:id])
		@listing.destroy
		redirect_to listings_path(@listings)
	end
end