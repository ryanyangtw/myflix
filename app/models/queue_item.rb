class QueueItem < ActiveRecord::Base

  belongs_to :user
  belongs_to :video

  # validates_uniqueness_of :video, scope: :user_id

  # delegate category method to video ( queue_item.category == queue_item.video.category)
  delegate :category, to: :video
  # delegate title method to video with prefix video ( queue_item.video_title == queue_item.video.title)
  delegate :title, to: :video, prefix: :video


  # def video_title
  #   video.title
  # end

  # Todo: Fixme: It should use the average value
  def rating
    # review = Review.where(user_id: user.id, video_id: video.id).first
    review = Review.find_by(user_id: user.id, video_id: video.id)
    review.rating if review
  end

  def category_name
    video.category.name
  end

  # def category
  #   video.category
  # end

end