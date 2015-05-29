class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id])
    #queue_video(video)
    current_user.queue_video!(video)
    redirect_to my_queue_path
  end

  def destroy
    # Teleaf version
    # queue_item = QueueItem.find(params[:id])
    # queue_item.destroy if current_user.queue_items.include?(queue_item)
    # redirect_to my_queue_path

    # My Version
    queue_item = current_user.queue_items.find_by(id: params[:id])
    queue_item.destroy if queue_item #queue_item.present?
    redirect_to my_queue_path


  end


=begin
  private

  def queue_video(video)
    QueueItem.create(video: video, 
                     user: current_user, 
                     position: new_queue_item_position) unless current_user_queued_video?(video)
  end

  # Todo: Fixme: If someone remove the item in queue will cause the proble. 
  def new_queue_item_position
    current_user.queue_items.count + 1
  end

  def current_user_queued_video?(video)
    #current_user.queue_items.exists?(video)
    current_user.queue_items.map(&:video).include?(video)
  end
=end

end