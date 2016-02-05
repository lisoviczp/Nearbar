class AddWeekdayToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :weekday, :string
  end
end
