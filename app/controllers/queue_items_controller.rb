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
    current_user.normalize_queue_item_positions!
    # normalize_queue_item_positions
    redirect_to my_queue_path

  end

  # queue_items: [{id: 4, positiion: 3}, {id: 2, position: 1}]
  def update_queue
    begin
      current_user.update_queue_items!(params[:queue_items])
      current_user.normalize_queue_item_positions!
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Invalid position numbers."
      #redirect_to my_queue_path
      #return
    end

    redirect_to my_queue_path
  end

=begin
  def update_queue
    begin
      update_queue_items
      normalize_queue_item_positions
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Invalid position numbers."
      #redirect_to my_queue_path
      #return
    end

    redirect_to my_queue_path
  end
=end


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


  def update_queue_items
    ActiveRecord::Base.transaction do
      params[:queue_items].each do |queue_item_data|
        queue_item = QueueItem.find(queue_item_data["id"])
        queue_item.update_attributes!(position: queue_item_data["position"]) if queue_item.user == current_user
      end
    end
  end

  def normalize_queue_item_positions
    current_user.queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index+1)
    end
  end

=end

end