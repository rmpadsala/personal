class AddBraintreeSubscriptionIdToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :braintree_subscription_id, :string
  end
end
