class AddDrinksToEstablishments < ActiveRecord::Migration
  def change
    add_column :establishments, :drinks, :text
  end
end
