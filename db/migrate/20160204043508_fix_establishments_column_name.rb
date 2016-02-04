class FixEstablishmentsColumnName < ActiveRecord::Migration
  def change
    rename_column :establishments, :email, :contact_info
  end
end
