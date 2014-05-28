class SubscriptionsController < ApplicationController
	before_filter :authenticate_algofast_user!

	def info
		@subscriptions = current_algofast_user.subscriptions
	end

	# GET /subscriptions
	# GET all the subscriptions that belongs to algofast_user
	def index 
		current_algofast_user.with_braintree_data!
		credit_card = current_algofast_user.default_credit_card
		@subscriptions = current_algofast_user.subscriptions

		#result = @subscriptions.find_by_payment_token(
		#	credit_card.token)	
	end	

	# GET /susbseriptions/1	
	def show
		@subscription = current_algofast_user.subscriptions.find(
			params[:id])
		redirect_to subscriptions_path
	end

	# DELETE /subscriptions/1
	def destroy
		Rails.logger.debug("destroy_subscription: id #{params[:id]}")
		@subscription = current_algofast_user.subscriptions.find(
			params[:id])

		if @subscription.nil?
			lash[:notice] = "Can't find subscription"
		else
			if @subscription.braintree_subscription_id
				cancel_subscription(
					braintree_subscription_id: @subscription.braintree_subscription_id)
				if @subscription_result.success?
					@subscription.destroy
					flash[:success] = "Subscription cancelled successfully"
				else
					flash[:alert] = "Error cancelling subscription"				
				end
			else
				flash[:notice] = "Invalid braintree_subscription_id"	
			end			
		end
		redirect_to subscriptions_path
	end

	# GET /susbseriptions/new
	def new
		subscription_id = params[:subscription_id]
		# redierct to add braintree customer path if no braintree id
		redirect_to new_customer_path(
			:subscription_id => subscription_id) unless current_algofast_user.is_registered_with_braintree?			
		
		current_algofast_user.with_braintree_data!
		credit_card = current_algofast_user.default_credit_card

		if !credit_card.nil?
			@subscription = current_algofast_user.subscriptions.new(
	            name: subscription_id,
	            description: SUBSCRIPTIONS[subscription_id],
	            braintree_customer_id: current_algofast_user.braintree_customer_id,
	            algofast_user_id: current_algofast_user.id,
	            payment_token: credit_card.token)
		else			
			@subscription = current_algofast_user.subscriptions.new(
	            name: subscription_id,
	            description: SUBSCRIPTIONS[subscription_id],
	            braintree_customer_id: current_algofast_user.braintree_customer_id,
	            algofast_user_id: current_algofast_user.id)
		end

		Rails.logger.debug("new_subscription: #{@subscription.to_json}" )
	end

	def create
		Rails.logger.debug("create_subscription: #{params[:subscription]}" )
		@subscription = current_algofast_user.subscriptions.new(
			subscription_params)
		
		current_algofast_user.with_braintree_data!
		credit_card = current_algofast_user.default_credit_card

    	if !credit_card.nil?
    		@subscription.payment_token = credit_card.token    		

			# Braintree Subscription Transaction
			create_subscription(
				payment_token: @subscription.payment_token, 
          		plan_id: @subscription.name)

        	if @subscription_result.success? 
        		@subscription.braintree_subscription_id = @subscription_result.subscription.id
        		@current_algofast_user.save!
				flash[:notice] = "Subscription successful"
				redirect_to @subscription		  
			else
		  		render 'info'
			end
		else
			flash[:notice] = "No valid payment information found"
			render 'info'
		end
	end

	private
		# Strong parameters
		def subscription_params
      		params.require(:subscription).permit(:name, :description, 
      			:payment_token, :algofast_user_id, :braintree_customer_id) if params[:subscription]
		end

		# Create subscription helper method
		def create_subscription(options={})
			if options[:plan_id] == :AF_SINGLE_ACTIVATION_01.to_s				
				@subscription_result = Braintree::Subscription.create(
				  :payment_method_token => options[:payment_token],
				  :plan_id => options[:plan_id],
				  :add_ons => {
				    :add => [
				      {
				        :inherited_from_id => :ONE_TIME_SINGLE_ACTIVATION_ADD_ON.to_s
				      }
				    ]
				  })
			else
				@subscription_result = Braintree::Subscription.create(
				  :payment_method_token => options[:payment_token],
				  :plan_id => options[:plan_id])
			end
			Rails.logger.debug("customer_controller#confirm, subscription_result: #{@subscription_result.inspect}")
	    end

	    # Cancel subscription helper method
	    def cancel_subscription(options={})
	    	@subscription_result = Braintree::Subscription.cancel(
	    		options[:braintree_subscription_id])
	    end	    
end
