require 'rails_helper'

RSpec.describe VideosController, :type => :controller do
  
  describe "GET show" do
    # Flatter way in solution video
    it "sets @video for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
       expect(assigns(:video)).to eq(video)
    end

    it "redirects the user to the sign in page for unauthenticated users" do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to sign_in_path
    end

# Too many nested 
=begin
    context "with authenticated users" do
      before do
        session[:user_id] = Fabricate(:user).id
      end
      it "sets @video" do
        video = Fabricate(:video)
        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
      end

      # # Rails give us. We don't need to test that
      # it "renders the show template" do
      #   video = Fabricate(:video)
      #   get :show, id: video.id 
      #   expect(response).to render_template(:show)
      # end
    end

    context "with unauthnticated users" do
      it "redirects the user to the sign in page" do
        video = Fabricate(:video)
        get :show, id: video.id
        expect(response).to redirect_to sign_in_path
      end
    end 
=end
  end # end of describe "GET show"

  describe "Get search" do
    it "sets @results for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      futurama = Fabricate(:video, title: 'Futurama') # override the default value in video_fabricator
      get :search, search_term: 'rama'
      expect(assigns(:results)).to eq([futurama])
    end

    it "redirects to sign in page for the unauthenticated users" do
      futurama = Fabricate(:video, title: 'Futurama')
      get :search, search_term: 'rama'
      expect(response).to redirect_to sign_in_path
    end
  end  # end of describe "Get search"

# Solution video using Post to search method. But I use Get
=begin
  describe "Post search" do
    it "sets @results for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      futurama = Fabricate(:video, title: 'Futurama') # override the default value in video_fabricator
      post :search, search_term: 'rama'
      expect(assigns(:results)).to eq([futurama])
    end

    it "redirects to sign in page for the unauthenticated users" do
      futurama = Fabricate(:video, title: 'Futurama')
      post :search, search_term: 'rama'
      expect(response).to redirect_to sign_in_path
    end
  end
=end
  
end