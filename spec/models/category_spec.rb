require 'rails_helper'

RSpec.describe Category, :type => :model do
  
  it { should have_many(:videos) }
  

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