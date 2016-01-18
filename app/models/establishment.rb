class Establishment < ActiveRecord::Base

	has_many :deals
	belongs_to :user

	has_many :favorite_establishments
	has_many :favorited_by, through: :favorite_establishments, source: :user
	
end
