class AddAwardToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :award, :string
  end
end
