class Video < ActiveRecord::Base

  #validates_uniqueness_of :title
  validates_presence_of :title, :description


  belongs_to :category
  has_many :reviews, -> { order(created_at: :desc) }
  has_many :queue_items

  mount_uploader :large_cover, LargeCoverUploader
  mount_uploader :small_cover, SmallCoverUploader

  def self.search_by_title(search_term)
    # return [] if search_term.blank?
    return Video.none if search_term.blank?
    where("title LIKE ?", "%#{search_term}%").order(created_at: :desc)
  end

end
