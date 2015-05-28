class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @video = Video.find(params[:video_id])
    review = @video.reviews.build(review_params.merge!(user: current_user))

    if review.save
      redirect_to video_path(@video)
      # redirect_to @video
    else
      # reload. Rails will reload data from database. And the invalid data will be throw away 
      @reviews = @video.reviews.reload
      render "videos/show"
    end

  end


  private 

  def review_params 
    params.require(:review).permit(:rating, :content)
  end

end