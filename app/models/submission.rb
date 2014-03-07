class Submission < ActiveRecord::Base
  belongs_to :user
  has_many :ratings
  has_attached_file :file
  has_attached_file :screenshot
  
  attr_accessible :approved, :description, :agreed, :title, :url, :file, :screenshot, :user

  validates :title, presence: true, length: { minimum: 3, maximum: 140 }
  validates :description, presence: true, length: { minimum: 60, maximum: 1500 }
  validates :agreed, acceptance: { accept: true }
  validates :user, presence: true

  validates :url, presence: { message: "Cannot be blank if you aren't uploading a file."},
            length: { minimum: 7, maximum: 255 }, if: :no_file
  
  validates_attachment_presence :file, if: :no_url
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z|\A.*pdf\Z|\A.*html\Z|\A.*zip\Z/i
  
  validates_attachment_presence :screenshot
  validates_attachment_content_type :screenshot, content_type: /\Aimage\/.*\Z/i

  default_scope { where(approved: true) }
  scope :recent, order("created_at DESC")

  paginates_per 10

  def next
    self.class.where("id > ?", id).order("id ASC").first
  end

  def prev
    self.class.where("id < ?", id).order("id DESC").first
  end


  def average_rating
    return 0 if self.ratings.empty?
    self.ratings.sum(:score) / self.ratings.count
  end

  def average_user_rating # excludes judge ratings
    return 0 if self.ratings.empty?
    self.ratings.select { |r| !r.user.judge? }.sum { |r| r.score }
  end

  def average_judge_rating
    return 0 if self.ratings.empty?
    self.ratings.select { |r| r.user.judge? }.sum { |r| r.score }
  end


  def user_name
    self.user.name
  end


  alias_method :previous, :prev

  private

    def no_file
      self.file.blank?
    end

    def no_url
      self.url.nil?
    end

end
