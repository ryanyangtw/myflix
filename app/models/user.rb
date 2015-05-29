class User < ActiveRecord::Base

  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email

  has_secure_password validations: false

  has_many :reviews
  has_many :queue_items


  def queue_video!(video)
    queue_items.create(video: video, 
                       position: new_queue_item_position) unless queued_video?(video)
  end

  def queued_video?(video)
    queue_items.map(&:video).include?(video)
  end


  private

  # Todo: Fixme: If someone remove the item in queue will cause the problem. 
  def new_queue_item_position
    queue_items.count + 1
  end

end