class Deal < ActiveRecord::Base

	belongs_to :establishment

	# Favorited by users
	has_many :favorite_deals # just the 'relationships'
	has_many :favorited_deals_by, through: :favorite_deals, source: :user # the actual users favoriting a deal


	def self.search(search)
	  # if search
	  #   find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
	  # else
	  #   find(:all)
	  if search
	  	where('keyword LIKE?', "%#{search}%")
	  else
	  	scoped
	  end
	end


	def get_likes
		@count=0
		User.all.each do |user|
			if user.favorited_deals.include? self
				@count+=1
			end
		end	
		@count
	end

end
