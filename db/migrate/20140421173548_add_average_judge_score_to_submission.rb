class AddAverageJudgeScoreToSubmission < ActiveRecord::Migration
  def change
    add_column :submissions, :average_judge_score, :integer, default: 0
  end
end
