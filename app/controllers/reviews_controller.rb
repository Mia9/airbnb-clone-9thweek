class ReviewsController < ApplicationController
	def new
		@listing = Listing.find_by(id: params[:listing_id])
		@review = Review.new
	end

	def create
		@listing = Listing.find_by(id: params[:review][:listing_id])
		@review = current_user.reviews.create(comment: params[:review][:comment],
					reviewable_id: @listing.id, reviewable_type: @listing.class)
		if @review.save
			redirect_to listing_path(@listing)
		else
			render :new
		end
	end
end