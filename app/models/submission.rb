class Submission < ActiveRecord::Base
  belongs_to :user
  has_many :ratings
  has_attached_file :file
  has_attached_file :screenshot
  
  attr_accessible :approved, :description, :agreed, :title, :url, :file, :screenshot, :user

  before_validation :smart_add_url_protocol

  validates :title, presence: true, length: { minimum: 3, maximum: 140 }
  validates :description, presence: true, length: { minimum: 60, maximum: 1500 }
  validates :agreed, acceptance: { accept: true }
  validates :user, presence: true

  validates :url, presence: { message: "URL cannot be blank if you aren't uploading a file."},
            length: { minimum: 7, maximum: 255 }, if: :no_file
  
  validates_attachment_presence :file, if: :no_url
  validates_attachment_content_type :file,
    content_type: /\Aimage\/.*\Z|\A.*pdf\Z|\A.*html\Z|\A.*zip\Z|\A.*7z-compressed\Z/i,
    message: "Must be an image, pdf, html, zip, or 7z. You attempted to upload a #{self.inspect}"
  
  validates_attachment_presence :screenshot
  validates_attachment_content_type :screenshot, content_type: /\Aimage\/.*\Z/i

  default_scope { where(approved: true) }
  scope :recent, order("created_at DESC")

  scope :newest, order("created_at DESC").limit(5)
  scope :top,    order("average_score DESC").limit(5)

  scope :winners, where("award IS NOT NULL").order(:id)

  paginates_per 10

  def next
    self.class.where("id > ?", id).order("id ASC").first
  end

  def prev
    self.class.where("id < ?", id).order("id DESC").first
  end

  def average_rating
    return 0 if self.ratings.empty?
    self.ratings.sum(&:score) / self.ratings.count
  end

  def average_user_rating # excludes judge ratings
    return 0 if self.ratings.empty?
    average_out( self.ratings.includes(:user).select {|r| !r.user.judge?} )
  end

  def average_judge_rating
    return 0 if self.judge_ratings.empty?
    average_out( self.judge_ratings )
  end

  def winner?
    !award.nil?
  end

  # alias_method :average_score,        :average_rating
  # alias_method :average_user_score,   :average_user_rating
  # alias_method :average_judge_score,  :average_judge_rating

  def average_out(ratings)
    ratings.sum(&:score) / ratings.count
  end

  def user_name
    self.user.name
  end

  def judge_ratings
    self.ratings.includes(:user).select {|r| r.user.judge?}
  end


  alias_method :previous, :prev

  protected

  def smart_add_url_protocol
    unless self.url.blank? || self.url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//]
      self.url = "http://#{self.url}"
    end
  end

  private

    def no_file
      self.file.blank?
    end

    def no_url
      self.url.nil?
    end


end
