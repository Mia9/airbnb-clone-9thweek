class ReviewsController < ApplicationController
	before_action :authenticate_user!
	def new
		# if current_user coming from user dashboard page
		if @user = User.find_by(id: params[:user_id])
		   @review = Review.new
		# 	show user review form in erb
		else
		# 	show review listing form in erb		
		@listing = Listing.find_by(id: params[:listing_id])
		@review = Review.new
		end
	end
	
	def create		
		@listing = Listing.find_by(id: params[:review][:listing_id])
		@review = current_user.reviews.create(comment: params[:review][:comment], rating: params[:review][:rating],
					reviewable_id: @listing.id, reviewable_type: @listing.class)
		if @review.save
			# redirect_to listing_path(@listing)
			render turbo_stream: turbo_stream.append("review_form", partial:"review", locals: { review: @review})
		else
			render :new
		end		
	end
end

# def new #-----before add on user review part
	# 	@listing = Listing.find_by(id: params[:listing_id])
	# 	@review = Review.new
	# end
