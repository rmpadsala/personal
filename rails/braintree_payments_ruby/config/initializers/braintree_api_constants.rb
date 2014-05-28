
#Braintree::Configuration.environment = (Rails.env.production?) ? :production : :sandbox
Braintree::Configuration.environment = ENV['braintree_environment'] == "production" ? :production : :sandbox
Braintree::Configuration.merchant_id = ENV['braintree_merchant_id']
Braintree::Configuration.public_key = ENV['braintree_public_key']	
Braintree::Configuration.private_key = ENV['braintree_private_key']

# Subscriptions constants
SUBSCRIPTIONS = ActiveSupport::HashWithIndifferentAccess.new
SUBSCRIPTIONS[:AF_NASDAQ_01] = "NASDAQ"
SUBSCRIPTIONS[:AF_TR_01] = "Thompson Reuters"
SUBSCRIPTIONS[:AF_SINGLE_ACTIVATION_01] = "Per indicator subscription"  
SINGLE_ACTIVATION_ADD_ON = "ONE_TIME_SINGLE_ACTIVATION_ADD_ON"