class CustomerController < ApplicationController
  before_filter :authenticate_algofast_user!
  
  # GET customers/new
  def new
    @subscription = params[:subscription_id]
    Rails.logger.debug("new_customer, subscription_id: #{@subscription}")
    set_customer_new_tr_data(@subscription)
  end

  # GET customers/1/edit
  def edit
    current_algofast_user.with_braintree_data!    
    Rails.logger.debug("edit_customer, credit_card: #{@credit_card.inspect}")
    set_customer_edit_tr_data
  end

  def confirm    
    @result = Braintree::TransparentRedirect.confirm(
      request.query_string)        

    @subscription = params[:subscription_id]
    Rails.logger.debug("confirm_customer, subscription_id: #{@subscription}")
    Rails.logger.debug("confirm_customer, result: #{@result.inspect}")

    # if braintree response is successful then 
    # 1. Store braintree customer id in database
    # 2. If new customer request, then create new subscription with supplied
    #    subscription_id
    # 3. If update customer request, then update algofast_user data and 
    #    redirect_to subscriptions_path
    if @result.success?
      # save customer info with braintree customer id
      current_algofast_user.braintree_customer_id = @result.customer.id
      current_algofast_user.save!

      # verify if response is for new customer or update customer
      if @subscription.nil?
        Rails.logger.info("customer #{current_algofast_user.email} information is successfully updated at braintree.")  
        # fetch latest data from braintree
        current_algofast_user.with_braintree_data!
        redirect_to subscriptions_path
      else        
        Rails.logger.info("customer #{current_algofast_user.email} is successfully added to braintree customer portal, id: #{@result.customer.id}")          
        redirect_to new_subscription_path(subscription_id: @subscription)
      end
    # if braintree response is for failed request and if user already have
    # registered at braintree then edit current paymet information and re-try    
    # REVISIT THIS ONCE AGAIN....
    elsif current_algofast_user.is_registered_with_braintree?
      current_algofast_user.with_braintree_data!       
      set_customer_edit_tr_data
      render :action => "edit" 
    # If braintree respons is for failed request and if user is NOT registered
    # with braintree yet, render new customer form   
    else
      set_customer_new_tr_data(@subscription)
      render :action => "new"
    end
  end

  private
    # Braintree Create Customer with Transperant Redirect api call
    def set_customer_new_tr_data(subscription)
      @year = DateTime.now().strftime('%Y')
      @tr_data = Braintree::TransparentRedirect.
        create_customer_data(:redirect_url => confirm_customer_url(
          :subscription_id => subscription))
    end

    # Braintree Edit Customer with Transperant Redirect api call
    def set_customer_edit_tr_data
      @year = DateTime.now().strftime('%Y')
      # if updating credit card along with customer use token of credit
      # card to update in TR data, else Braintree will create new credit
      # card instead of an updating existing one
      @tr_data = Braintree::TransparentRedirect.
        update_customer_data(:redirect_url => confirm_customer_url,
            :customer_id => current_algofast_user.braintree_customer_id,
            :customer => {
              :credit_card => {
                :options => {
                  :update_existing_token => current_algofast_user.default_credit_card.token                
                  },
                #uncomment following block when supporting billing address
                #:billing_address => {
                #  :options => {
                #    :update_existing => true
                #  }
                #}
              }
            })
    end    
end
