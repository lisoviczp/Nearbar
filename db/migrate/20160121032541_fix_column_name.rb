class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :deals, :current, :temporary
  end
end
