class User < ActiveRecord::Base
  has_many :ratings
  has_many :submissions
  attr_accessible :name

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
    end
  end

  def admin?
    admin
  end

  def judge?
    judge
  end

end
