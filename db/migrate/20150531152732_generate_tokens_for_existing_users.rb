class GenerateTokensForExistingUsers < ActiveRecord::Migration
  def change
    User.all.each do |user|
      user.generate_token
      user.save(validate: false)
    end
  end
end
