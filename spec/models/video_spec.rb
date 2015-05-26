require 'rails_helper'

RSpec.describe Video, :type => :model do

  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe ".search_by_title" do

    #let(:futurama) { Video.create(title: "Futurama", description: "Space Travel!") }
    #let(:back_to_future) { Video.create(title: "Back to Future", description: "Time Travel!") }
    before do
      @futurama = Video.create(title: "Futurama", description: "Space Travel!")
      @back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")
    end

    it "returns an empty array if there is no match" do
      
      expect(Video.search_by_title("hello")).to eq([])
      # expect(Video.search_by_title("hello")).to eq(Video.none)      
    end

    it "returns an array of one video for an exact match" do
      # futurama = Video.create(title: "Futurama", description: "Space Travel!")
      # back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")

      expect(Video.search_by_title("Futurama")).to eq([@futurama])
    end


    it "returns an array of one video for a partial match" do
      # futurama = Video.create(title: "Futurama", description: "Space Travel!")
      # back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")

      expect(Video.search_by_title("urama")).to eq([@futurama])
    end


    it "returns an array of all matches ordered by created_at" do
      # futurama = Video.create(title: "Futurama", description: "Space Travel!", created_at: 1.day.ago)
      # back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")

      expect(Video.search_by_title("Futur")).to eq([@back_to_future, @futurama])
    end

    it "returns an empty array for a search with an empth string" do
      # futurama = Video.create(title: "Futurama", description: "Space Travel!", created_at: 1.day.ago)
      # back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")
  
      expect(Video.search_by_title("")).to eq([])
    end

  end
  


# We use shoulda-matcher to simpfly below
=begin
  it "saves itself" do 
    video = Video.new(title: "monk", description: "a great video!")
    video.save
    expect(Video.first).to eq(video)
    # Video.first.should == video
    # Video.first.should eq(video)

  end

  it "belongs to category" do
    dramas = Category.create(name: "dramas")
    monk = Video.create(title: "monk", description: "a great video!", category: dramas)
    expect(monk.category).to eq(dramas)
  end

  it "does not save a video without a title" do
    video = Video.create(description: "a great video!")
    expect(Video.count).to eq(0)
    # expect(video).to_not be_valid
  end

  it "does not save a video without a description" do
    video = Video.create(title: "monk")
    expect(Video.count).to eq(0)
    # expect(video).to_not be_valid
  end
=end

end