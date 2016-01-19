class User < ActiveRecord::Base

	has_many :establishments

	# Favorite establishments of user
	has_many :favorite_establishments
	has_many :favorites, through: :favorite_establishments, source: :establishment

	# Favorite deals of user
	has_many :favorite_deals # just the 'relationships'
	has_many :favorited_deals, through: :favorite_deals, source: :deal # the actual deals a user favorites


end
