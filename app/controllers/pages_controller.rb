class PagesController < ApplicationController
	def index
		available_listings = Listing.available_only

		if params[:check_in].blank? and params[:check_out].blank? and params[:location].blank?
			@listings = available_listings.all
		else
			if params[:location].present?
				@listings = available_listings.where(location: params[:location])
			else
				@listings = available_listings.all
			end

			if params[:check_in].present? and params[:check_out].present?
				@unavailable_listings = Booking.where(check_in: params[:check_in]..params[:check_out])
				.or(Booking.where(check_out: params[:check_in]..params[:check_out]))
				.or(Booking.where("check_in <= ? AND check_out >= ?", params[:check_in],params[:check_out]))
				.pluck(:listing_id)

				@listings = @listings.where.not(id: @unavailable_listings)
			end
		end
	end
end