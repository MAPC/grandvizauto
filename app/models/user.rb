class User < ActiveRecord::Base
  has_many :ratings
  has_many :submissions
  attr_accessible :name, :email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, allow_blank: true, allow_nil: true,
             format: { with: VALID_EMAIL_REGEX }

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid      = auth["uid"]
      user.name     = auth["info"]["name"]
      user.email    = auth["info"]["email"] if auth["info"]["email"]
    end
  end

  def admin?
    admin
  end

  def judge?
    judge
  end

  def has_submissions?
    submissions.length > 0
  end

end
