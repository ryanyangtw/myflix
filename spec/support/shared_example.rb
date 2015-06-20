shared_examples "requires sign in" do
  it "redirects to the sign in page" do
    session[:user_id] = nil
    action
    expect(response).to redirect_to sign_in_path
  end
end

shared_examples "requires admin" do
  it "redirects to the home page" do
    session[:user_id] = Fabricate(:user).id
    action
    expect(response).to redirect_to home_path
  end
end

shared_examples "tokenable" do
  describe "#create_token!" do
    it "generates a random token" do
      object.update_columns(token: nil)
      object.create_token!
      expect(object.token).to be_present
    end
  end

  describe "#destroy_token!" do
    it "Remove the token" do
      object.update_columns(token: "Whatever")
      object.destroy_token!
      expect(object.token).to be_nil
    end
  end
end


# shared_examples "tokenable" do
#   it "generates a random token when the user is created" do
#     expect(object.token).to be_present
#   end
# end