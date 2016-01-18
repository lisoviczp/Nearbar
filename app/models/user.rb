class User < ActiveRecord::Base

	has_many :establishments

	has_many :favorite_establishments
	has_many :favorites, through: :favorite_establishments, source: :establishment

end
