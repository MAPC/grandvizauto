class User < ActiveRecord::Base
  has_many :ratings
  has_many :submissions
  attr_accessible :name, :admin, :judge
end
