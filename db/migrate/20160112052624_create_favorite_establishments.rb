class CreateFavoriteEstablishments < ActiveRecord::Migration
  def change
    create_table :favorite_establishments do |t|
      t.integer :establishment_id
      t.integer :user_id

      t.timestamps
    end
  end
end
