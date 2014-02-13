class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.boolean :admin
      t.boolean :judge
      
      t.timestamps
    end
  end
end
