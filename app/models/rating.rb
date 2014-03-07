class Rating < ActiveRecord::Base
  attr_accessible :score, :user, :submission, :user_id, :submission_id
  belongs_to :submission
  belongs_to :user

  validates :score, presence: true, inclusion: 0..5
  validates :user_id, uniqueness: { scope: :submission_id }

  

end
