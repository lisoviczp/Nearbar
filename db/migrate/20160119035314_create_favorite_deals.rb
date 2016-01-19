class CreateFavoriteDeals < ActiveRecord::Migration
  def change
    create_table :favorite_deals do |t|
      t.integer :deal_id
      t.integer :user_id

      t.timestamps
    end
  end
end
