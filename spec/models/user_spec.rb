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

end