require 'rails_helper'

RSpec.describe StripeWrapper, :type => :model do
   
  describe StripeWrapper::Charge do
    
    describe ".create" do  
      before do
        StripeWrapper.set_api_key
      end
      let(:token) do 
        token = Stripe::Token.create(
          :card => {
            :number => card_number,
            :exp_month => 6,
            :exp_year => 2018,
            :cvc => "314"
          },
        ).id
      end

      context "with valid card" do 
        let(:card_number) { '4242424242424242' }

        it "makes a successful charge", :vcr do
          # Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
          # response = StripeWrapper::Charge.create(
          #   amount: 999,
          #   source: token,
          #   description: "a valid charge"
          # )
          charge = StripeWrapper::Charge.create(
            amount: 999,
            source: token,
            description: "a valid charge"
          )

          expect(charge.response.amount).to eq(999)
          expect(charge.response.currency).to eq('usd')
        end

        it "charges the card successfully", :vcr do

          # Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
          card_number = '4242424242424242'
          
          response = StripeWrapper::Charge.create(
            amount: 300,
            source: token
          )

          expect(response).to be_successful
        end
      end # end of context "with valid card"

      context "with invalid card" do
        let(:card_number) { '4000000000000002' }
        let(:response) { response = StripeWrapper::Charge.create(amount: 300, source: token) }
        it "does not charge the card successfully", :vcr do
          expect(response).not_to be_successful 
        end

        it "contains an error message", :vcr do
          expect(response.error_message).to be_present
        end
      end # end of context "with invalid card"

    end # end of describe ".create"
  end # end of describe StripeWrapper::Charge


end