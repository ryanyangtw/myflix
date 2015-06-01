class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id])
    current_user.queue_video!(video)
    redirect_to my_queue_path
  end

  def destroy

    queue_item = current_user.queue_items.find_by(id: params[:id])
    queue_item.destroy if queue_item
    current_user.normalize_queue_item_positions!

    redirect_to my_queue_path
  end


  def update_queue
    begin
      update_queue_items
      current_user.normalize_queue_item_positions!
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Invalid position numbers."
    end

    redirect_to my_queue_path
  end



  private

  def update_queue_items
    ActiveRecord::Base.transaction do
      params[:queue_items].each do |queue_item_data|
        queue_item = current_user.queue_items.find_by(id: queue_item_data["id"])
        queue_item.update!(position: queue_item_data["position"], rating: queue_item_data["rating"]) if queue_item
      end
    end
  end


end