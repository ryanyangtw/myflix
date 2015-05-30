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
        expect(User.count).to eq(1)
      end

      it "redirects to the sign in page" do
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
  end # end of describe "GET show"

end
