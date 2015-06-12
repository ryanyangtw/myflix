class Invitation < ActiveRecord::Base
  include Tokenable

  belongs_to :inviter, class_name: "User"

  validates_presence_of :recipient_name, :recipient_email, :message 

  after_create :create_token!


end