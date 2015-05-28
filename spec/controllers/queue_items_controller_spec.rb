require 'rails_helper'

RSpec.describe QueueItemsController, :type => :controller do 

  describe "GET index" do
    it "sets @queue_items to the queue items of the loggid in user" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      vedio1 = Fabricate(:video)
      vedio2 = Fabricate(:video)
      queue_item1 = Fabricate(:queue_item, user: alice, video: vedio1)
      queue_item2 = Fabricate(:queue_item, user: alice, video: vedio2)

      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it "redirects to the sign in page for unauthenticated users" do
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end # end of describe "GET index"


  describe "POST create" do
    it "redirects a queue item" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to(my_queue_path)
    end

    it "creates a queue item" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end

    it "creates the queue item that is associated with the video" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end

    it "creates the queue item that is associated with the sign in user" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(alice)
    end

    it "puts the video as the last one in the queue" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      monk = Fabricate(:video)
      Fabricate(:queue_item, video: monk, user: alice)
      south_park = Fabricate(:video)
      post :create, video_id: south_park.id
      # In general "take" will be faster than first, because the database does not have to identify all of the rows that meet the criteria and then sort them and find the lowest-sorting row. "take" allows the database to stop as soon as it has found a single row.
      south_park_queue_item = QueueItem.where(video_id: south_park, user_id: alice.id).take 
      expect(south_park_queue_item.position).to eq(2)
    end


    it "does not add the video the queue if the video is already in the queue" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      monk = Fabricate(:video)
      Fabricate(:queue_item, video: monk, user: alice)
      post :create, video_id: monk.id
      expect(alice.queue_items.count).to eq(1)
    end


    it "redirects to the sign in page for unauthenticated users" do
      post :create, video_id: 3
      expect(response).to redirect_to sign_in_path
    end

  end # end of describe "POST create"



end