class Rating < ActiveRecord::Base
  attr_accessible :score
  belongs_to :submission
  belongs_to :user

  validates :score, presence: true, inclusion: 0..5

  

end
