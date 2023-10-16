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

	# def new #-----before add on user review part
	# 	@listing = Listing.find_by(id: params[:listing_id])
	# 	@review = Review.new
	# end

	def create
		if @user = User.find_by(id: params[:user_id])
		   @review = current_user.reviews.create(comment: params[:review][:comment], rating: params[:review][:rating],
						reviewable_id: @user.id, reviewable_type: @user.class)
			if @review.save
				redirect_to user_path(@user)
			else
				render :new
			end
			
		else
			@listing = Listing.find_by(id: params[:review][:listing_id])
			@review = current_user.reviews.create(comment: params[:review][:comment], rating: params[:review][:rating],
						reviewable_id: @listing.id, reviewable_type: @listing.class)
			if @review.save
				redirect_to listing_path(@listing)
			else
				render :new
			end
		end
	end

	# def create #need another if else for user review? #---before add user review part
	# 	@listing = Listing.find_by(id: params[:review][:listing_id])
	# 	@review = current_user.reviews.create(comment: params[:review][:comment], rating: params[:review][:rating],
	# 				reviewable_id: @listing.id, reviewable_type: @listing.class)
	# 	if @review.save
	# 		redirect_to listing_path(@listing)
	# 	else
	# 		render :new
	# 	end
	# end
end