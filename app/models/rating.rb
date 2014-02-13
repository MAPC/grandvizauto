class Rating < ActiveRecord::Base
  attr_accessible :score
  belongs_to :submission
  belongs_to :user
end
