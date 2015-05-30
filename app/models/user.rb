class User < ActiveRecord::Base

  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email

  has_secure_password validations: false

  has_many :reviews, -> { order(created_at: :desc) }
  has_many :queue_items, -> { order(:position) } # default is asc

  def queue_video!(video)
    queue_items.create(video: video, 
                       position: new_queue_item_position) unless queued_video?(video)
  end

  def queued_video?(video)
    queue_items.map(&:video).include?(video)
  end


  # def update_queue_items!(queue_items_data)
  #   ActiveRecord::Base.transaction do
  #     queue_items_data.each do |queue_item_data|
  #       queue_item = queue_items.find_by(id: queue_item_data["id"])
  #       # In rails4 update! is preferred than update_attributes! 
  #       queue_item.update!(position: queue_item_data["position"]) if queue_item
  #     end
  #   end
  # end

  def normalize_queue_item_positions!
    queue_items.each_with_index do |queue_item, index|
      queue_item.update(position: index+1)
    end
  end


  private

  # Todo: Fixme: If someone remove the item in queue will cause the problem. 
  def new_queue_item_position
    queue_items.count + 1
  end

end