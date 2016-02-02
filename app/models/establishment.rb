class Establishment < ActiveRecord::Base

	has_many :deals
	belongs_to :user

	has_many :favorite_establishments
	has_many :favorited_by, through: :favorite_establishments, source: :user


	def self.search(search)
	  # if search
	  #   find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
	  # else
	  #   find(:all)
	  if search
	  	where('name LIKE?', "%#{search}%")
	  else
	  	scoped
	  end
	end

	def total_active_deals
		@current_user=User.first

		@count=0
		if self.deals.where(active: true).size > 0
			@count=self.deals.where(active: true).size
		end

		@count
	end


	def total_deals
		@current_user=User.first
		@establishments=@current_user.establishments
		@count=0

		if self.deals.where(current: true).size > 0
			@count += self.deals.where(current: true).size 
		end
		if self.deals.where(permanent: true).size 
			@count += self.deals.where(permanent: true).size 
		end

		@count
	end

	def total_users_favorited
		# @current_user = User.first
		@total_favorites = self.favorited_by.size
	end

end
