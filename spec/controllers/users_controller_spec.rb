require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "GET new" do
    it "sets @user" do
      get "new"
      expect(assigns(:user)).to be_a_new(User)
      # expect(assigns(:user)).to be_instance_of(User)
    end
  end # end of describe "GET new"


  describe "POST create" do    
    
    context "with valid input" do

      before do
        post :create, user: Fabricate.attributes_for(:user)
      end

      it "creates the user" do
        # Fabricate.attributes_for(:user) is like User.new
        # post :create, user: { email: "kevin@example.com", password: "password", full_name: "Kevin Wang" }
        # post :create, user: Fabricate.attributes_for(:user)
        expect(User.count).to eq(1)
      end

      it "redirects to the sign in page" do
        # post :create, user: Fabricate.attributes_for(:user)
        expect(response).to redirect_to sign_in_path
      end
    end # end of context "with valid input"
    
    
    context "with invalid input" do

      before do
        post :create, user: { password: "password", full_name: "Kevin Wang" }
      end

      it "does not create the user" do
        expect(User.count).to eq(0)
      end
      
      it "render the :new template" do
        expect(response).to render_template(:new)
      end
      
      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end # end of context "with invalid input"


    context "sending emails" do
      # Email sending is added to ActionMailer::Base.deliveries queue.
      # There are not part of database transaction. So this will not be rollback.
      # We have to do something to make sure after every spec run, The ActionMailer::Base.deliveries queue also be restored
      after { ActionMailer::Base.deliveries.clear } 

      it "sends out email to the user with valid inputs" do
        post :create, user: { email: "joe@example.com", password: "password", full_name: "Joe Smith" }
        expect(ActionMailer::Base.deliveries.last.to).to eq(['joe@example.com'])
      end

      it "sends out email containing the user's name with valid inputs" do
        post :create, user: { email: "joe@example.com", password: "password", full_name: "Joe Smith" }
        expect(ActionMailer::Base.deliveries.last.body).to include("Joe Smith")
      end

      it "does not send out email with invalid inputs" do
        post :create, user: { email: "joe@example.com" }
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end # end of context "sending emails"

  end # end of describe "POST create"


  describe "GET show" do
    
    it_behaves_like "requires sign in" do
      let(:action) { get :show, id: 3 }
    end  

    it "sets@ user" do
      set_current_user
      alice = Fabricate(:user)
      get :show, id: alice.id
      expect(assigns(:user)).to eq(alice)
    end
  end

end
