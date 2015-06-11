module Tokenable
  extend ActiveSupport::Concern

 # include do
  #   before_create :generate_token
  # end

  # def generate_token
  #   self.token = SecureRandom.urlsafe_base64
  # end

  def create_token!
    self.update_columns(token: generate_token)
  end

  def destroy_token!
    self.update_columns(token: nil)
  end

  def generate_token 
    loop do
      token =  SecureRandom.urlsafe_base64
      # self.token = token
      break token unless self.class.find_by(token: token)
      # break token unless User.find_by(token: token)
    end
    # self.token = SecureRandom.urlsafe_base64
  end
end