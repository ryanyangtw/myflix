class Category < ActiveRecord::Base
  
  #validates_uniqueness_of :name

  has_many :videos, -> { order(created_at: :desc) }

  def recent_videos
    videos.first(6)
  end

end
