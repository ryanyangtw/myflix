class GenerateTokensForExistingUsers < ActiveRecord::Migration
  def change
    User.all.each do |user|
      # user.update_columns(token: SecureRandom.urlsafe_base64)
      user.generate_token
      user.save(validate: false)
    end
  end
end
