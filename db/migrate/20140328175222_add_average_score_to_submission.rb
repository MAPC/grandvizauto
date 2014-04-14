class AddAverageScoreToSubmission < ActiveRecord::Migration
  def change
    add_column :submissions, :average_score, :integer, default: 0
  end
end
