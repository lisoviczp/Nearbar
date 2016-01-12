class FavoriteEstablishment < ActiveRecord::Base

	belongs_to :user
	belongs_to :establishment
end
