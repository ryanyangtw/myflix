class User < ActiveRecord::Base

  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email

  has_secure_password validations: false

  has_many :reviews, -> { order(created_at: :desc) }
  has_many :queue_items, -> { order(:position) } 
  has_many :following_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :leading_relationships, class_name: "Relationship", foreign_key: :leader_id


  def queue_video!(video)
    queue_items.create(video: video, 
                       position: new_queue_item_position) unless queued_video?(video)
  end

  def queued_video?(video)
    queue_items.map(&:video).include?(video)
  end

  def normalize_queue_item_positions!
    queue_items.each_with_index do |queue_item, index|
      queue_item.update(position: index+1)
    end
  end

  def follows?(another_user)
    following_relationships.map(&:leader).include?(another_user)
  end

  def can_follow?(another_user)
    !self.follows?(another_user) && self != another_user
  end

  def create_token!
    self.update_columns(token: generate_token)
  end

  def destroy_token!
    self.update_columns(token: nil)
  end


  private
 
  def new_queue_item_position
    queue_items.count + 1
  end

  def generate_token 
    loop do
      token =  SecureRandom.urlsafe_base64
      break token unless User.find_by(token: token)
    end
  end

end