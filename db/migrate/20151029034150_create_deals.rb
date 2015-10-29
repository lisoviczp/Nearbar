class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :keyword
      t.text :description
      t.boolean :current
      t.boolean :permanent

      t.timestamps
    end
  end
end
