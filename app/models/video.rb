class Video < ActiveRecord::Base

  #validates_uniqueness_of :title

  belongs_to :category
  has_many :reviews

  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    # return [] if search_term.blank?
    return Video.none if search_term.blank?
    where("title LIKE ?", "%#{search_term}%").order(created_at: :desc)
  end

end
