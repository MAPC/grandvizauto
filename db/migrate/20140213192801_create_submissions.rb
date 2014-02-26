class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.references :user
      t.string :title
      t.text :description
      t.string :url
      t.boolean :agreed, default: false
      t.boolean :approved, default: false

      t.timestamps
    end
    add_index :submissions, :user_id
  end
end
