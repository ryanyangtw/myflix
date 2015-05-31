require 'rails_helper'

feature 'User following' do

  scenario "user follows and unfollows someone" do

    alice = Fabricate(:user)
    category = Fabricate(:category)
    video = Fabricate(:video, category: category)
    Fabricate(:review, user: alice, video: video)

    sign_in
    click_on_video_on_home_page(video)

    click_link alice.full_name
    click_link "Follow"
    expect(page).to have_content(alice.full_name)

    unfollow(alice)
    expect(page).not_to have_content(alice.full_name)
  end

  def unfollow(user)
    href = "/relationships/#{user.leading_relationships.first.id}"
    find("a[href='#{href}']").click
    # find("a[data-method='delete']").click  # Because I change the sign_out link to delete method
  end

end