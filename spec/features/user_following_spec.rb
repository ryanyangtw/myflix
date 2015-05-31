require 'rails_helper'

feature 'User following' do

  scenario "user follows and unfollows someone" do

    alice = Fabricate(:user)
    category = Fabricate(:category)
    video = Fabricate(:video, category: category)
    Fabricate(:review, user: alice, video: video)

    sign_in
    click_on_video_on_home_page(video)

    click_reviewer_name_on_video_page(alice)
    follow_the_user_on_user_page
    expect(page).to have_content(alice.full_name)

    unfollow(alice)
    expect(page).not_to have_content(alice.full_name)
  end

  def click_reviewer_name_on_video_page(user)
    click_link user.full_name
  end

  def follow_the_user_on_user_page
    click_link "Follow"
  end

  def unfollow(user)
    href = "/relationships/#{user.leading_relationships.first.id}"
    find("a[href='#{href}']").click
  end

end