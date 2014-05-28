class AlgofastUser < ActiveRecord::Base
  FIELDS = [:first_name, :last_name, :phone, :website, :company, :fax, 
    :addresses, :credit_cards, :custom_fields]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # algofast_user to subscriptions association, dependent on destroy
  # method so that when algofast_user is deleted, associated 
  # subscription gets deleted by invoking destroy method.
  has_many :subscriptions, dependent: :destroy
  has_many :strategy_records, dependent: :destroy

  # Setup accessible (or protected) attributes for your model
  attr_accessor *FIELDS
  
  # Check if user is registered with braintree or not
  def is_registered_with_braintree?
  	!!braintree_customer_id
  end  

  # Set attributes with current braintree information
  def with_braintree_data!
    return self unless is_registered_with_braintree?

    braintree_data = Braintree::Customer.find(braintree_customer_id)

    FIELDS.each do |field|
      send(:"#{field}=", braintree_data.send(field))
    end
    self
  end

  # Get default credit card information, this method should be used in
  # conjuction with with_braintree_data! method to make sure we have 
  # correct information.
  def default_credit_card
    return unless is_registered_with_braintree?

    credit_cards.find { |cc| cc.default? }
  end

  # Check if users have valid credit cards
  def has_valid_credit_cards?
    return false unless is_registered_with_braintree?

    # fetch braintree data
    braintree_data = Braintree::Customer.find(braintree_customer_id)
    # check if credit cards has valid tokens
    !braintree_data.credit_cards.map { |cc| cc.token }.empty?
  end

  # Check if users have any active subscriptions
  def has_active_subscriptions?
    return false unless is_registered_with_braintree?

    !subscriptions.empty?
  end

  # Check if user is subscribed to thompson reuters plan
  def is_subscribed_to_thompson_reuters?
    return false unless has_active_subscriptions?

    !subscriptions.find_by_name(:AF_TR_01).nil?
  end

  # Check if user is subscribed to NASDAQ plan
  def is_subscribed_to_NASDAQ?
    return false unless has_active_subscriptions?

    !subscriptions.find_by_name(:AF_NASDAQ_01).nil?
  end

  # Check if user is subscribed to single activation plan
  def is_subscribed_to_single_activation?
    return false unless has_active_subscriptions?

    !subscriptions.find_by_name(:AF_SINGLE_ACTIVATION_01).nil?
  end
end
