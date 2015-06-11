class Invitation < ActiveRecord::Base
  belongs_to :inviter, class_name: "User"

  validates_presence_of :recipient_name, :recipient_email, :message 

  after_create :create_token!

  def create_token!
    self.update_columns(token: generate_token)
  end

  def destroy_token!
    self.update_columns(token: nil)
  end


  private

  def generate_token 
    loop do
      token =  SecureRandom.urlsafe_base64
      break token unless Invitation.find_by(token: token)
    end
  end

end