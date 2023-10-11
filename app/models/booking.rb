class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  after_create :calculate_duration
  after_create :calculate_total_price

  def calculate_duration
    self.duration = (check_out.to_date - check_in.to_date).to_i
    self.save
  end

  def calculate_total_price
    self.total_price = duration * listing.price
    self.save
  end

end
