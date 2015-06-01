require 'rails_helper'

RSpec.describe Category, :type => :model do

  it { is_expected.to have_many(:videos) }
  it { is_expected.to validate_presence_of(:name) }

  describe "#recent_videos" do

    let(:comedies) { Fabricate(:category) }

    it "returns the videos in the reverse chronical order by created_at" do
      futurama = Fabricate(:video, category: comedies, created_at: 1.day.ago )
      south_park = Fabricate(:video, category: comedies )
      expect(comedies.recent_videos).to eq([south_park, futurama])
    end

    it "returns all the videos if there are less than 6 videos" do
      futurama = Fabricate(:video, category: comedies, created_at: 1.day.ago )
      south_park = Fabricate(:video, category: comedies )
      expect(comedies.recent_videos.count).to eq(2)
    end

    it "returns 6 videos if there are more than 6 videos" do
      7.times { Fabricate(:video, category: comedies) }
      expect(comedies.recent_videos.count).to eq(6)
    end

    it "returns the most recet 6 videos" do
      6.times { Fabricate(:video, category: comedies) }
      tonights_show = Fabricate(:video, category: comedies, created_at: 1.day.ago)  
      expect(comedies.recent_videos).not_to include(tonights_show)
    end

    it "returns an empty array if the category does not have any videos" do
      expect(comedies.recent_videos).to eq([])
    end


  end
  

end