class User < ActiveRecord::Base
  has_many :ratings
  has_many :submissions
  attr_accessible :name, :email, :ip, :confirmed, :confirmation_code

  before_save :create_confirmation_code

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, allow_blank: true, allow_nil: true,
             format: { with: VALID_EMAIL_REGEX }
  validates :email, presence: true, on: :update

  def self.create_with_omniauth_and_ip(auth, ip)
    create! do |user|
      user.provider  = auth["provider"]
      user.uid       = auth["uid"]
      user.name      = auth["info"]["name"]
      user.email     = auth["info"]["email"] if auth["info"]["email"]
      user.ip        = ip

      user.confirmed = true if user.email
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

  private

    def create_confirmation_code
      self.confirmation_code = SecureRandom.hex(32) unless self.confirmed?
    end

  

end
