class AddConfirmationAndIpToUsers < ActiveRecord::Migration
  def change
    add_column :users, :confirmed, :boolean
    add_column :users, :confirmation_code, :string
    add_column :users, :ip, :string
  end
end
