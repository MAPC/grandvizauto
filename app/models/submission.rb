class Submission < ActiveRecord::Base
  belongs_to :user
  has_many :ratings
  has_attached_file :file
  
  attr_accessible :approved, :description, :agreed, :title, :url, :file

  validates :title, presence: true, length: { minimum: 3, maximum: 140 }
  validates :description, presence: true, length: { minimum: 60, maximum: 1500 }
  validates :agreed, acceptance: { accept: true }

  # presence true if has upload
  validates :url, presence: true, length: { minimum: 7, maximum: 255 }, if: :no_file
  # validate if no url
  # validates_attachment :file

  paginates_per 10

  def next
    self.class.where("id > ?", id).order("id ASC").first
  end

  def prev
    self.class.where("id < ?", id).order("id DESC").first
  end

  alias_method :previous, :prev

  private

    def no_file
      self.file.blank?
    end

end
