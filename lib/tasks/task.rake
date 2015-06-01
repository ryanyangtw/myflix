namespace :dev do
  desc "Generate Tokens For Existing Users"
  task :generate_token_for_existing_users => :environment do
    User.all.each do |user|
      user.create_token!
    end
  end
end