class AddTimesToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :start_time, :time
    add_column :deals, :end_time, :time
  end
end
