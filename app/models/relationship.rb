class Relationship < ActiveRecord::Base

  # When we define belongs_to :follower. Default will use follower_id as foreign_key
  belongs_to :follower, class_name: "User"  # foreign_key: follower_id
  belongs_to :leader, class_name: "User"

end