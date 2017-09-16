 # Store the environment variables on the Rails.configuration object
 Rails.configuration.stripe = {
   publishable_key: ENV['pk_test_AZfBGyJ1Jgqoaea9uV70hIQN'],
   secret_key: ENV['sk_test_KB0byxO5TSlBUExjWJzJrS6N']
 }
 
 # Set our app-stored secret key with Stripe
 Stripe.api_key = Rails.configuration.stripe[:secret_key]