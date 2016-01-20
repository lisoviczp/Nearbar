class AddActiveToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :active, :boolean
  end
end
