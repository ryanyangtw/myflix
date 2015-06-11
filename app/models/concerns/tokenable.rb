module Tokenable
  extend ActiveSupport::Concern

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
      break token unless self.class.find_by(token: token)
    end
  end

end