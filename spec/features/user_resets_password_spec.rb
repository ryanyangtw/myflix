require 'rails_helper'

feature 'User resets password' do
  scenario 'user successfully resets the password' do
    alice = Fabricate(:user, password: 'old_password')

    request_password_reset_email(alice)
    follow_link_in_email(alice)
    reset_password
    sign_in_with_valid_password(alice)

    expect(page).to have_content("Welcome, #{alice.full_name}")
 
    clear_email
  end

  def request_password_reset_email(user)
    visit sign_in_path
    click_link "Forgot Password?"
    fill_in "Email Address", with: user.email 
    click_button "Send Email"
  end

  def follow_link_in_email(user)
    open_email(user.email)
    current_email.click_link("Reset My Password")
  end

  def reset_password
    fill_in "New Password", with: "new_password"
    click_button "Reset Password"
  end

  def sign_in_with_valid_password(user)
    fill_in "Email Address", with: user.email
    fill_in "Password", with: "new_password"
    click_button "Sign in"
  end

end