class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :score
      t.integer :submission_id
      t.integer :user_id

      t.timestamps
    end
    add_index :ratings, :user_id
    add_index :ratings, :submission_id
  end
end
