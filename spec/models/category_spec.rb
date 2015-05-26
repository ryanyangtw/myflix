require 'rails_helper'

RSpec.describe Category, :type => :model do

  it { should have_many(:videos) }

  describe "#recent_videos" do

    let(:comedies) { Category.create(name: "comedies") }
    
    it "returns the videos in the reverse chronical order by created_at" do
      futurama = Video.create(title: "Futurama", description: "space travel!", category: comedies, created_at: 1.day.ago)
      south_park = Video.create(title: "South Park", description: "crazy kids!", category: comedies)

      expect(comedies.recent_videos).to eq([south_park, futurama])
    end

    it "returns all the videos if there are less than 6 videos" do
      futurama = Video.create(title: "Futurama", description: "space travel!", category: comedies, created_at: 1.day.ago)
      south_park = Video.create(title: "South Park", description: "crazy kids!", category: comedies)

      expect(comedies.recent_videos.count).to eq(2)
    end

    it "returns 6 videos if there are more than 6 videos" do
      7.times { Video.create(title: "foo", description: "bar", category: comedies) }

      expect(comedies.recent_videos.count).to eq(6)
    end

    it "returns the most recet 6 videos" do
      6.times { Video.create(title: "foo", description: "bar", category: comedies) }
      tonights_show = Video.create(title: "Tonights show", description: "talk show", category: comedies, created_at: 1.day.ago)

      expect(comedies.recent_videos).not_to include(tonights_show)
    end

    it "returns an empty array if the category does not have any videos" do
      expect(comedies.recent_videos).to eq([])
    end


  end
  

# We use shoulda-matcher to simpfly below
=begin 
  it "saves itself" do 
    category = Category.new(name: "comedies")
    category.save
    expect(Category.first).to eq(category)

    
  end

  it "has many videos" do
    comedies = Category.create(name: "comedies")
    south_park = Video.create(title: "South Park", description: "Funny video!", category: comedies)
    futurama = Video.create(title: "Futurama", description: "Space travel!", category: comedies)

    # include confirm the object in the association but not coonfirm partically order
    # expect(comedies.videos).to include(south_park, futurama)

    # it's check the order
    #expect(comedies.videos).to eq([futurama, south_park])

  end
=end

end