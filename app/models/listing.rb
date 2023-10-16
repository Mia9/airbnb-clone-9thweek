class Listing < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :reviews, as: :reviewable
  has_many_attached :photos

  scope :available_only, -> { where(available: true)}
end
