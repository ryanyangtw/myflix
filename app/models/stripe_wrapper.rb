module StripeWrapper

  class Charge
    attr_accessor :response, :status
    
    def initialize(response, status)
      self.response = response
      self.status = status
    end

    def self.create(options={})
      StripeWrapper.set_api_key
      begin
        response = Stripe::Charge.create(
          amount: options[:amount],
          currency: 'usd',
          source: options[:source],
          description: options[:description]
        )
        new(response, :success)
      rescue Stripe::CardError => e 
        new(e, :error)
      end
    end

    def successful?
      status == :success
    end

    def error_message
      response.message
    end
  end

  def self.set_api_key
    Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
    # Stripe.api_key = Rails.env.production? ? ENV["STRIPE_SECRET_KEY"] : "test_api_key"
  end
end