class Deal < ActiveRecord::Base

	belongs_to :establishment

	# Favorited by users
	has_many :favorite_deals # just the 'relationships'
	has_many :favorited_deals_by, through: :favorite_deals, source: :user # the actual users favoriting a deal

end
