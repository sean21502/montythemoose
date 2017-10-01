class ChargesController < ApplicationController

	def create
  # Creates a Stripe Customer object, for associating
  # with the charge
    
  	customer = Stripe::Customer.create(
    	email: current_user.email,
    	card: params[:stripeToken]
  	)
 
  # Where the real magic happens

  	Stripe::Charge.create(
      customer: customer.id,
      amount: 15_00,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
    )

  	current_user.update_attribute(:role, 'premium')
 
  	flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
  	redirect_to wikis_path(current_user) # or wherever
 
  # Stripe will send back CardErrors, with friendly messages
  # when something goes wrong.
  # This `rescue block` catches and displays those errors.
  	rescue Stripe::CardError => e
    	flash[:alert] = e.message
    	redirect_to new_charge_path
	end

	def new
  	@stripe_btn_data = {
    	key: "#{ Rails.configuration.stripe[:publishable_key] }",
    	description: "Premium Membership - #{current_user}",
    	amount: 15_00
  	}
	end

	def downgrade
		@user = current_user
		@user.downgrade
		flash[:notice] = "Bye #{current_user.email}!"
    @wikis.each do |wiki|
      if wiki.private == true
        wiki.update_attributes!(private: false)
      end
		redirect_to root_path
	end
end