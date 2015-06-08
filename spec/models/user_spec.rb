require 'rails_helper'

RSpec.describe User, :type => :model do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_presence_of(:full_name) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to have_many(:reviews).order(created_at: :desc) }
  it { is_expected.to have_many(:queue_items).order(:position) }
  it { is_expected.to have_many(:following_relationships).class_name('Relationship').with_foreign_key(:follower_id) }
  it { is_expected.to have_many(:leading_relationships).class_name('Relationship').with_foreign_key(:leader_id) }

  # it "generates a random token when the user is created" do
  #   alice = Fabricate(:user)
  #   expect(alice.token).to be_present
  # end

  describe '#create_token!' do
    it "create new token" do
      alice = Fabricate(:user)
      alice.create_token!
      expect(alice.token).to be_present
    end
  end

  describe '#destroy_token!' do
    it "destroy the token" do
      alice = Fabricate(:user)
      alice.destroy_token!
      expect(alice.token).to be_nil
    end
  end

  describe "#queued_video?" do
    it "returns true when the user queued the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, user: user, video: video)
      expect(user.queued_video?(video)).to be true
    end

    it "returns false when the user hasn't queued the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      expect(user.queued_video?(video)).to be false
    end
  end # end of describe "#queued_video?"

  
  describe "#follows?" do
    it "returns true if the user has a following relationship with another user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, leader: bob, follower: alice)
      expect(alice.follows?(bob)).to be true
    end
    
    it "returns false if the user does not have a following relationship with another user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, leader: alice, follower: bob)
      expect(alice.follows?(bob)).to be false
    end
  end #end of describe "#follows?"

  describe "#follow" do
    it "follows another user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      alice.follow(bob)
      expect(alice.follows?(bob)).to be true
    end

    it "does not follow one self" do
      alice = Fabricate(:user)
      alice.follow(alice)
      expect(alice.follows?(alice)).to be false
    end

  end
end