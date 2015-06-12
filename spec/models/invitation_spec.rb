require 'rails_helper'



RSpec.describe Invitation, :type => :model do
  it { should validate_presence_of(:recipient_name) }
  it { should validate_presence_of(:recipient_email) }
  it { should validate_presence_of(:message) }
  it { is_expected.to belong_to(:inviter) } 

  it_behaves_like "tokenable" do
    let(:object) { Fabricate(:invitation) }
  end
  
end