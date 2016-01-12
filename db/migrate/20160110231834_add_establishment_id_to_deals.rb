class AddEstablishmentIdToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :establishment_id, :integer
  end
end
