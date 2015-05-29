class QueueItem < ActiveRecord::Base

  validates_numericality_of :position, { only_integer: true }

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
  # Virtual attribute for activerecord model
  def rating
    # review = Review.where(user_id: user.id, video_id: video.id).first
    #review = Review.find_by(user_id: user.id, video_id: video.id)
    review.rating if review
  end

  # Virtual attribute for activerecord model
  def rating=(new_rating)
    #review = Review.find_by(user_id: user.id, video_id: video.id)
    
    if review
      # In Rails4 update_columns is preffered than update_column
      # update_columns will bypass the validation
      review.update_columns(rating: new_rating)
      #review.update(rating: new_rating)
    else
      review = Review.new(user: user, video: video, rating: new_rating)
      review.save(validate: false)
    end

  end

  def category_name
    video.category.name
  end

  # def category
  #   video.category
  # end

  private 

  def review
    # memorization
    @review ||= Review.find_by(user_id: user.id, video_id: video.id)
  end

end