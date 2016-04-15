class Movie < ActiveRecord::Base

  scope :Under90, ->  { where("runtime_in_minutes < ?", 90) }
  scope :Between90and120, -> { where("runtime_in_minutes > ? AND runtime_in_minutes < ?", 90, 120) } 
  scope :Over120, -> { where("runtime_in_minutes > ?", 120) } 

  has_many :reviews

  mount_uploader :poster, PosterUploader

  validates :title,
  presence: true

  validates :director,
  presence: true

  validates :runtime_in_minutes,
  numericality: { only_integer: true }

  validates :description,
  presence: true

  # validates :poster_image_url,
  # presence: true

  validates :poster,
  presence: true

  validates :release_date,
  presence: true

  validate :release_date_is_in_the_past


  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      erros.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end
end
