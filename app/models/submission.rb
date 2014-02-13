class Submission < ActiveRecord::Base
  belongs_to :user
  has_many :ratings
  attr_accessible :approved, :description, :rules, :title, :url
end
