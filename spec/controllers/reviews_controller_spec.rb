require 'rails_helper'

RSpec.describe ReviewsController, :type => :controller do 

  describe "POST cteate" do

    let(:video) { Fabricate(:video) }

    context "with authenticated users" do
      
      let(:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user.id } 

      context "with valid inputs" do

        before do
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        end

        it "redirects to the video show page" do
          expect(response).to redirect_to video_path(video)
        end
        
        it "creates a review" do 
          expect(Review.count).to eq(1)
        end

        it "creates a review associated with the video" do
          expect(Review.first.video).to eq(video)
        end
        
        it "creates a review associated with the signed in user" do
          expect(Review.first.user).to eq(current_user)
        end

      end # end of context "with valid inputs"
      

      context "with invalid inputs" do
        it "does not create a review"  do
          post :create, review: {rating: 4}, video_id: video.id
          expect(Review.count).to eq(0)
        end

        it "renders the video/show template" do
          post :create, review: {rating: 4}, video_id: video.id
          expect(response).to render_template("videos/show")
        end

        it "sets @video" do
          post :create, review: {rating: 4}, video_id: video.id
          expect(assigns(:video)).to eq(video)
        end

        it "sets @reviws" do
          review = Fabricate(:review, video: video)
          post :create, review: {rating: 4}, video_id: video.id
          expect(assigns(:reviews)).to match_array([review])
        end
      end # end of context "with invalid inputs"
    
    end # end of context "with authenticated users"


    context "with unauthenticated users" do
      it "redirects to the sign in path" do
        post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        expect(response).to redirect_to sign_in_path
      end
    end # end of context "with unauthenticated users"

  end # end of describe "POST cteate"


end