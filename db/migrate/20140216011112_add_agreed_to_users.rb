class AddAgreedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :agreed, :boolean
  end
end
